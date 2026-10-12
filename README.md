# APB-SPI Master IP Core – UVM Verification

## Overview

This project focuses on the functional verification of an **APB-interfaced SPI Master IP Core** using Verilog HDL, SystemVerilog, and Universal Verification Methodology (UVM).

The verification environment checks APB transactions, SPI data communication, and expected behavior using a scoreboard, functional coverage, and SystemVerilog Assertions (SVA).

## Features

- APB Slave Interface
- SPI Master Communication
- Programmable Baud-Rate Generation
- Serial Data Shifting and Slave-Select Control
- SystemVerilog and UVM-Based Verification
- Scoreboard-Based Data Checking
- Functional Coverage Analysis
- SystemVerilog Assertions (SVA)
- Regression Testing and Simulation Debugging

## Project Structure

```text
APB-SPI-Master-IP-Core/
├── RTL/
│   ├── APB_SLAVE_INTERFACE.v
│   ├── Top_module.v
│   ├── baudrate_generator.v
│   ├── shift_register.v
│   └── spi_slave_control_select.v
├── VERIFICATION/
│   ├── interface/
│   ├── sequences/
│   ├── agent/
│   ├── scoreboard/
│   ├── environment/
│   └── tests/
├── Simulation/
├── README.md
└── LICENSE
```

## Verification Plan

- Verify APB read and write transactions.
- Check SPI clock generation and serial data transmission/reception.
- Validate slave-select control operation.
- Test reset behavior and multiple transactions.
- Compare expected and observed data using a scoreboard.
- Measure functional coverage.
- Check protocol behavior using SystemVerilog Assertions.
- Run regression tests and debug simulation results.

## Simulation Results

- **Expected Data:** `10101010`
- **Observed MISO Data:** `10101010`
- **Data Comparison:** PASS
- **UVM Errors:** 0
- **UVM Warnings:** 0
- **UVM Fatals:** 0

*Results reflect the displayed simulation report and the test scenarios executed.*

## Tools and Technologies

- **HDL:** Verilog HDL
- **Verification Language:** SystemVerilog
- **Methodology:** UVM
- **Simulators:** QuestaSim, Synopsys VCS
- **FPGA Design Tools:** Xilinx Vivado (where applicable)
- **Verification Techniques:** Scoreboard, Functional Coverage, Assertions, Regression Testing

## Author


RTL Design | Design Verification | SystemVerilog | UVM

## Repository

[APB-SPI Master IP Core – GitHub](https://github.com/shaikyedullahussen/APB-SPI-Master-IP-Core)
