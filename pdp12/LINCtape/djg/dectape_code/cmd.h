#define CMD_NONE        0
#define CMD_EXIT        1
#define CMD_READ_TAPE   2
#define CMD_READ_TAPE_REV 3

#define CMD_STATUS_WAIT_READY 0x100
#define CMD_STATUS_OK       0x200

#define SMEM_WRITE_PTR (0/INDD+SMEM_OFFSET)     // Write pointer location in RAM
#define SMEM_CMD  (4/INDD+SMEM_OFFSET)          // Command location
#define SMEM_CMD_DATA (8/INDD+SMEM_OFFSET)     // Command data
#define SMEM_DRIVE_STATUS (12/INDD+SMEM_OFFSET) // Drive status, only valid when idle

#define STOP_ADDR (0x4000000)
#define LMEM_DDR_ADDR 0    // Error flag in RAM
#define LMEM_DDR_MASK (4/INDD)    // Error flag in RAM

#define R30_STOP_BIT 6
#define R30_FORWARD_BIT 7
#define R31_RTT_BIT 2
#define R31_RTT_MASK (1 << R31_RTT_BIT)
#define R31_RMT_BIT 1
#define R31_RMT_MASK (1 << R31_RMT_BIT)
#define R31_RD0_BIT 3
#define R31_RD0_MASK (1 << R31_RD0_BIT)
#define R31_RD1_BIT 4
#define R31_RD1_MASK (1 << R31_RD1_BIT)
#define R31_RD2_BIT 5
#define R31_RD2_MASK (1 << R31_RD2_BIT)
#define R31_BIT_MASK (R31_RTT_MASK | R31_RMT_MASK | R31_RD0_MASK | R31_RD1_MASK | R31_RD2_MASK)
