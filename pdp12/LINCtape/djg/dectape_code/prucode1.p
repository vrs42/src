// prucode.p

.origin 0
.entrypoint START

#include "prucode.hp"

#define GPIO2 0x481Ac000
#define GPIO1 0x4804c000
#define GPIO_CLEARDATAOUT 0x190
#define GPIO_SETDATAOUT 0x194

#define DRAM_MASK (0x40000 - 1)

START:

    // Enable OCP master port
    LBCO      r0, CONST_PRUCFG, 4, 4
    CLR     r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, CONST_PRUCFG, 4, 4

    // Configure the programmable pointer register for PRU0 by setting c28_pointer[15:0]
    // field to 0x0120.  This will make C28 point to 0x00012000 (PRU shared RAM).
    MOV     r0, 0x00000120
    MOV       r1, CTPPR_0
    ST32      r0, r1

    // Configure the programmable pointer register for PRU0 by setting c31_pointer[15:0]
    // field to 0x0010.  This will make C31 point to 0x80001000 (DDR memory).
    MOV     r0, 0x00100000
    MOV       r1, CTPPR_1
    ST32      r0, r1

#ifdef ignore
    MOV       r3, PRU0_CONTROL_REG  // Enable cycle counter
    LD32      r2, r3
    SET       r2, r2, 3
    ST32      r2, r3
    MOV       r20, PRU0_CYCLE_COUNTER_REG
#endif


#ifdef ignore
    MOV       r0, 0x10   // Time stamp free run
    SBCO      r0, CONST_ECAP, 0x2a, 4
    MOV       r0, 0x0   // Clear count
    SBCO      r0, CONST_ECAP, 0, 4
#endif


//    LBCO      r0, CONST_DDR, 0, 4 // Read word from DDR. This takes 42 cycles
//    SBCO      r0, CONST_DDR, 0, 4 // Write word to DDR. This takes 2 cycles

//    SBCO      r0, CONST_PRURAM, 0, 4 // This takes 2 cycles

    MOV       r21, 0 // DRAM OFFSET
    MOV       r22, DRAM_MASK
    LBCO      r23, CONST_PRURAM, 0, 4
    MOV       r24, r23
    ADD       r23, r23, 4
    MOV       r0, 0
    SBBO      r0, r24, 0, 4 // Write word to DDR. This takes 2 cycles

#ifdef ignore
//JMP DONE
    SUB       r23, r23, 4
    MOV       r3, 0x7ffc
LL:
    SBBO      r0, r23, r21, 4
    ADD       r21, r21, 4
    QBNE      L1,r21,r3
    MOV       r21,0
    //AND       r21, r21, r22
//    SBBO      r21, r24, 0, 4 // Write word to DDR. This takes 2 cycles
L1:
    ADD       r0,r0,0x1
JMP LL
#endif
JMP DONE
    MOV       r2, 0
    SBCO      r2, CONST_PRURAM, 4, 4
LL:
    LBCO      r0, CONST_ECAP, 0, 4 // 4 cycles
    LBCO      r3, CONST_PRURAM, 8, 4
    LBCO      r1, CONST_ECAP, 0, 4 // 4 cycles
    SUB       r1, r1, r0
    QBLE      LL, r2, r1
    MOV       r2, r1
    SBCO      r2, CONST_PRURAM, 4, 4
    JMP LL

    


    MOV      r2, 0x4000 
lw1:	
    //QBBS      lw1, r31, 7
    
    LBCO      r0, CONST_ECAP, 0, 4 // 4 cycles
    //SBBO      r0, r23, r21, 4 // 4 cycles
    ADD       r21, r21, 4  // 1 cycle
    AND       r21, r21, r22 // 1 cycle
    //SBBO      r21, r24, r2, 4 // 4 cycles
    SBBO      r21, r24, 0, 4 // 2 cycles
    JMP       lw1

lw0:	
    //QBBC      lw0, r31, 7

    LBCO      r0, CONST_ECAP, 0, 4
    //SBBO      r0, r23, r21, 4
    ADD       r21, r21, 4
    AND       r21, r21, r22
    JMP       lw1

DONE:
    // Send notification to Host for program completion
    MOV       r31.b0, PRU0_ARM_INTERRUPT+16

    // Halt the processor
    HALT

