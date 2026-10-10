
  class apb_spi_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;

   // Factory Registration
        `uvm_component_utils(apb_spi_virtual_sequencer)

   // LAB : Declare dynamic array of handles for ram_wr_sequencer and ram_rd_sequencer as wr_seqrh[] & rd_seqrh[]
        apb_sequencer apb_seqrh[];
        spi_sequencer spi_seqrh[];


   // LAB : Declare handle for ram_env_config
        apb_spi_env_config m_cfg;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name = "apb_spi_virtual_sequencer",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        endclass

   // Define Constructor new() function
        function apb_spi_virtual_sequencer::new(string name="apb_spi_virtual_sequencer",uvm_component parent);
                super.new(name,parent);
        endfunction
