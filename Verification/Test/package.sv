
package pck;
        import uvm_pkg::*;

         `include "register.sv"
         `include "reg_block.sv"
        `include "uvm_macros.svh"
        `include "apb_agent_config.sv"
        `include "spi_agent_config.sv"
        `include "env_config.sv"

        `include "apb_trans.sv"
        `include "apb_seqs.sv"
        `include "apb_sequencer.sv"
        `include "apb_driver.sv"
        `include "apb_monitor.sv"
        `include "apb_agent.sv"
        `include "apb_agt_top.sv"

        `include "spi_trans.sv"
        `include "spi_seqs.sv"
        `include "spi_sequencer.sv"
        `include "spi_driver.sv"
        `include "spi_monitor.sv"
        `include "spi_agent.sv"
        `include "spi_agt_top.sv"

        `include "sb.sv"
        `include "env_tb.sv"
        `include "base_test.sv"

endpackage
