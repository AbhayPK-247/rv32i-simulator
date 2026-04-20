# rv32i-simulator
# RV32I Single Cycle Processor

A complete implementation of a RISC-V 32-bit integer (RV32I) single cycle processor in Verilog, designed for ASIC tapeout using Cadence Genus and Innovus.

---

## Overview

This project implements a fully functional RV32I single cycle CPU from scratch in Verilog. Every instruction completes in a single clock cycle. The design was verified through behavioral simulation in Vivado and includes a browser-based assembly IDE that simulates the exact hardware behavior.

---

## Architecture
                ┌─────────────┐
      ┌────────►│  rv32i_imem │◄──── PC
      │         └─────────────┘
      │               │ instruction
      │    ┌──────────┼──────────┐
      │    ▼          ▼          ▼
      │  control   imm_gen   reg_file
      │    │          │       │    │
      │    └──────────┼───────┘    │
      │               ▼            │
      │           alu_control      │
      │               │            │
      │               ▼            ▼
      │            rv32i_alu ◄─────┘
      │               │
      │               ▼
      │           rv32i_dmem
      │               │
      └─── PC ◄── next_pc_logic

## Module Breakdown

| Module | Description |
|---|---|
| `rv32i_top.v` | Top level — wires all modules together |
| `rv32i_pc.v` | Program counter — updates on posedge clk |
| `rv32i_imem.v` | Instruction memory — combinational read |
| `rv32i_control_unit.v` | Decodes opcode → control signals |
| `rv32i_reg_file.v` | 32 x 32-bit registers, x0 hardwired to 0 |
| `rv32i_imm_gen.v` | Generates immediates for all 5 formats |
| `rv32i_alu_control.v` | ALUOp + funct3 + funct7 → alu_ctrl |
| `rv32i_alu.v` | Executes ADD/SUB/AND/OR/XOR/SLL/SRL/SRA/SLT |
| `rv32i_dmem.v` | Data memory — sync write, async read |
| `rv32i_tb.v` | Testbench |

---

## Supported Instructions

**R-type:** `ADD SUB AND OR XOR SLL SRL SRA SLT`

**I-type:** `ADDI ANDI ORI XORI SLLI SRLI SRAI SLTI LW JALR`

**S-type:** `SW`

**B-type:** `BEQ BNE BLT BGE`

**U-type:** `LUI AUIPC`

**J-type:** `JAL`

---

## Simulation Results

Verified in Vivado 2023.2 behavioral simulation:
[  1]  PC=0x00000000  ADDI   x1(ra)=0x0000000A
[  2]  PC=0x00000004  ADDI   x2(sp)=0x00000005
[  3]  PC=0x00000008  ADD    x3(gp)=0x0000000F
[  4]  PC=0x0000000C  SUB    x4(tp)=0x00000005
[  5]  PC=0x00000010  AND    x5(t0)=0x00000000

---

## Browser Simulator

An interactive RV32I assembly IDE that simulates the exact Verilog datapath logic in the browser.

Live demo: [AbhayPK-247.github.io/rv32i-simulator](https://AbhayPK-247.github.io/rv32i-simulator)

Features:
- Write RV32I assembly directly
- Step through execution cycle by cycle
- Watch register file update in real time
- Full execution trace with ALU results and memory operations

---

## Tapeout Flow
RTL (Vivado simulation)
→ Genus synthesis (.sdc + standard cell library)
→ Innovus place & route
→ DRC / LVS signoff
→ GDS tapeout

---

## Files
rv32i-simulator/
├── src/
│   ├── rv32i_top.v
│   ├── rv32i_pc.v
│   ├── rv32i_imem.v
│   ├── rv32i_dmem.v
│   ├── rv32i_reg_file.v
│   ├── rv32i_alu.v
│   ├── rv32i_alu_control.v
│   ├── rv32i_control_unit.v
│   └── rv32i_imm_gen.v
├── sim/
│   └── rv32i_tb.v
├── index.html        ← browser simulator
└── README.md

---

## Tools Used

- Vivado 2023.2 — RTL simulation
- Cadence Genus — synthesis (in progress)
- Cadence Innovus — place & route (upcoming)

---
