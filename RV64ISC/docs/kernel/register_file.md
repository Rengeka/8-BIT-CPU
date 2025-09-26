# Register file

## RISC-V 64I registers

| №  | Registers  | Names     | Description                                  |
|-----|-----------|-----------|----------------------------------------------|
| 1   | x0        | zero      | Always contains 0 value. Is readonly         |
| 2   | x1        | ra        | Return address                               |
| 3   | x2        | sp        | Stack pointer                                |
| 4   | x3        | gp        | Global pointer                               |
| 5   | x4        | tp        | Thread pointer                               |
| 6   | x5-x7     | t0-t2     | Caller saved registers (temporary registers) |
| 7   | x8        | s0/fp     | Frame pointer. Is a saved register           |
| 8   | x9        | s1        | Is a saved register                          |
| 9   | x10-x17   | a0-a7     | Argument / return value registers            |
| 10  | x18-x27   | s2-s11    | Saved registers                              |
| 11  | x28-x31   | t3-t6     | Caller saved registers (temporary registers) |

## CSR (Control and status registers)

| No. | CSR     | Address | Description                                     |
|------|---------|---------|------------------------------------------------|
| 1    | mstatus | 0x300   | Machine status register                        |
| 2    | mie     | 0x304   | Machine interrupt-enable register              |
| 3    | mip     | 0x344   | Machine interrupt-pending register             |
| 4    | mtvec   | 0x305   | Machine trap-vector base address               |
| 5    | mepc    | 0x341   | Machine exception program counter              |
| 6    | mcause  | 0x342   | Machine cause register                         |
| 7    | satp    | 0x180   | Supervisor address translation and protection  |
