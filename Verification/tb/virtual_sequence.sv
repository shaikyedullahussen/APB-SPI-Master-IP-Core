
class apb_spi_vbase_seqs extends uvm_sequence #(uvm_sequence_item);


  // Factory registration
        `uvm_object_utils(ram_vbase_seq)
  // LAB : Declare dynamic array of handles for ram_wr_sequencer and ram_rd_sequencer as wr_seqrh[] & rd_seqrh[]
        apb_sequencer apb_seqrh[];
        spi_sequencer spi_seqrh[];
  // Declare handle for virtual sequencer
        apb_spi_virtual_sequencer vsqrh;
  // Declare Handles for all the sequences
        single_addr_apb_xtns single_apbxtns;
        single_addr_spi_xtns single_spixtns;

  // LAB :  Declare handle for ram_env_config
        apb_spi_env_config m_cfg;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name = "apb_spi_vbase_seqs");
        extern task body();
        endclass : apb_spi_vbase_seqs
//-----------------  constructor new method  -------------------//

// Add constructor
        function apb_spi_vbase_seqs::new(string name ="apb_spi_vbase_seqs");
                super.new(name);
        endfunction
//-----------------  task body() method  -------------------//


task apb_spi_vbase_seqs::body();
// get the config object ram_env_config from database using uvm_config_db
          if(!uvm_config_db #(apb_spi_env_config)::get(null,get_full_name(),"apb_spi_env_config",m_cfg))
                `uvm_fatal("UVM_CONFIG","cannot get env_config")
// initialize the dynamic arrays for write & read sequencers to m_cfg.no_of_duts
        apb_seqrh=new[m_cfg.no_of_duts];
        spi_seqrh=new[m_cfg.no_of_duts];

  assert($cast(vsqrh,m_sequencer))
   else
    begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
    end
// Assign ram_wr_sequencer & ram_rd_sequencer handles to virtual sequencer's
// ram_wr_sequencer & ram_rd_sequencer handles
// Hint : use foreach loop
        foreach(apb_seqrh[i])begin
                apb_seqrh[i]=vsqrh.apb_seqrh[i];
                            end
        foreach(spi_seqrh[i])begin
                spi_seqrh[i]=vsqrh.spi_seqrh[i];
                            end

endtask: body



//------------------------------------------------------------------------------
//                 single address sequence

//------------------------------------------------------------------------------
// Extend ram_single_vseq from ram_vbase_seq
        class single_vseq extends apb_spi_vbase_seqs;

     // Define Constructor new() function
        `uvm_object_utils(single_vseq)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name = "single_vseq");
        extern task body();
        endclass : single_vseq
//-----------------  constructor new method  -------------------//

// Add constructor
        function single_vseq::new(string name ="single_vseq");
                super.new(name);
        endfunction
//-----------------  task body() method  -------------------//

                task single_vseq::body();
                 super.body();
                 // LAB : create the instances for ram_single_addr_wr_xtns & ram_single_addr_rd_xtns
                         single_apbxtns=single_addr_apb_xtns::type_id::create("single_apbxtns");
                         single_spixtns=single_addr_spi_xtns::type_id::create("single_spixtns");

                    if(m_cfg.has_apb_agent) begin
                   for (int i=0 ; i < m_cfg.no_of_duts; i++)
                  // LAB : Start the write sequence on all the write sequencers
                      single_apbxtns.start(apb_seqrh[i]);
                                         end

                   if(m_cfg.has_spi_agent) begin
                   for (int i=0 ; i < m_cfg.no_of_duts; i++)
                  // LAB : Start the read sequence on all the read sequencers
                       single_spixtns.start(spi_seqrh[i]);
                                        end

       endtask
