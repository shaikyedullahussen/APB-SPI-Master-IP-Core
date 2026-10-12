APB-SPI Master IP Core – UVM Verification
Overview
Design and verification of an APB-interfaced SPI Master IP Core using Verilog HDL, SystemVerilog, and UVM.

Features
APB Slave Interface
SPI Master communication
Programmable baud-rate generation
Serial data shifting and slave-select control
UVM-based functional verification
Functional coverage and assertions
Project Structure
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
Verification Plan
APB read and write transactions
SPI clock and data transfer
Slave-select operation
Reset and multiple transactions
Scoreboard-based checking
Functional coverage and protocol assertions
Tools
Verilog HDL
SystemVerilog
UVM
QuestaSim / VCS
Xilinux,Vivado

RTL Design | Design Verification | SystemVerilog | UVM
