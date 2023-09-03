// prucode.p
.setcallreg r29.w0

.origin 0
.entrypoint START

#include "prucode.hp"

#define GPIO2 0x481Ac000
#define GPIO1 0x4804c000
#define GPIO_CLEARDATAOUT 0x190
#define GPIO_SETDATAOUT 0x194

#define SMEM_OFFSET 0
#define INDD 1

#include "cmd.h"

#define UP_TO_SPEED_TIME 30000000 // 150 milliseconds
#define NS_200 40 // 200 nanoseconds

START:

   // Enable OCP master port
   LBCO     r0, CONST_PRUCFG, 4, 4
   CLR      r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
   SBCO     r0, CONST_PRUCFG, 4, 4

   // Configure the programmable pointer register for PRU0 by setting c28_pointer[15:0]
   // field to 0x0120.  This will make C28 point to 0x00012000 (PRU shared RAM).
   MOV      r0, 0x00000120
   MOV      r1, CTPPR_0
   ST32     r0, r1

   // Configure the programmable pointer register for PRU0 by setting c31_pointer[15:0]
   // field to 0x0010.  This will make C31 point to 0x80001000 (DDR memory).
   MOV      r0, 0x00100000
   MOV      r1, CTPPR_1
   ST32     r0, r1


        // Setup ECAP as free running counter
   MOV       r0, 0x10   // Time stamp free run
   SBCO      r0, CONST_ECAP, 0x2a, 4

   LBCO     r23, CONST_PRURAM, LMEM_DDR_ADDR, 4  // Address of DDR buffer
            // Mask to wrap DDR buffer offset
   LBCO     r22, CONST_PRURAM, LMEM_DDR_MASK, 4  

   MOV      r0, CMD_STATUS_WAIT_READY
   SBCO     r0, CONST_PRUSHAREDRAM, SMEM_CMD, 4 // Waiting for drive ready

   MOV      r0, CMD_STATUS_OK
   SBCO     r0, CONST_PRUSHAREDRAM, SMEM_CMD, 4 
   MOV      r2,0              // This register is constant 0

wait_cmd:
   SBCO     r31, CONST_PRUSHAREDRAM, SMEM_DRIVE_STATUS, 4
   LBCO     r1, CONST_PRUSHAREDRAM, SMEM_CMD, 4 // Get command
   QBEQ     read_tape, r1, CMD_READ_TAPE
   QBEQ     read_tape_rev, r1, CMD_READ_TAPE_REV
   QBEQ     EXIT, r1, CMD_EXIT
   JMP      wait_cmd

read_tape_rev:
   CLR      r30, R30_FORWARD_BIT  // Backward
   JMP      do_read

read_tape:
   SET      r30, R30_FORWARD_BIT  // Forward
do_read:
   MOV      r21, 0                   // Offset in DDR buffer
   SBCO     r21, CONST_PRUSHAREDRAM, SMEM_WRITE_PTR, 4   // write ptr 

   MOV      r0, CMD_STATUS_OK
   SBCO     r0, CONST_PRUSHAREDRAM, SMEM_CMD, 4 

   MOV      r3, NS_200
   SBCO     r2, CONST_ECAP, 0, 4   // Clear time
delay1:
   LBCO     r0, CONST_ECAP, 0, 4
   QBLT     delay1, r3, r0

   CLR      r30, R30_STOP_BIT

   MOV      r3, UP_TO_SPEED_TIME
   SBCO     r2, CONST_ECAP, 0, 4   // Clear time
delay2:
   LBCO     r0, CONST_ECAP, 0, 4
   QBLT     delay2, r3, r0

   MOV      r5, r31
   SBCO     r2, CONST_ECAP, 0, 4   // Clear time
caploop:
   AND      r4, r31,R31_BIT_MASK
   QBEQ     caploop, r5, r4
   MOV      r5,r4
   //LBBO     r10.b1, r28, 0, 3    
   //LBCO     r10.b1, CONST_ECAP, 0, 3    // Load low 3 bytes of time, doesn't
                                          // work from ECAP
   LBCO     r10, CONST_ECAP, 0, 4    // Load time
   MOV      r10.b3, r5.b0               // And put in signal line state

   SBBO     r10, r23, r21, 4         // write times to ddr
   ADD      r21, r21, 4              // inc ptr
   AND      r21, r21, r22            // wrap if needed 
   SBCO     r21, CONST_PRUSHAREDRAM, SMEM_WRITE_PTR, 4   // write ptr 
   JMP      caploop

   MOV      r1, CMD_STATUS_OK
   SBCO     r1, CONST_PRUSHAREDRAM, SMEM_CMD, 4 // Indicate command completed ok
   JMP      wait_cmd   

EXIT:
   SET      r30, R30_STOP_BIT
   MOV      r1, CMD_STATUS_OK
   SBCO     r1, CONST_PRUSHAREDRAM, SMEM_CMD, 4 // Indicate command completed ok
DONE:
   // Send notification to Host for program completion
   MOV      r31.b0, PRU0_ARM_INTERRUPT+16

   // Halt the processor
   HALT

   // Restarted here to stop read
   .ORIGIN 0x400
   SET      r30, R30_STOP_BIT
   JMP      wait_cmd
