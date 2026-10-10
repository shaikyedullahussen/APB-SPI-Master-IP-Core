
class tb extends uvm_env;

    // Factory Registration
   `uvm_component_utils(tb)


        apb_agt_top apb_agent_top;
        spi_agt_top spi_agent_top;
        env_config e_cfg;
        scoreboard sb;

        extern function new(string name = "tb", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass: tb

//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function tb::new(string name = "tb" , uvm_component parent);
        super.new(name,parent);
endfunction

//-----------------  build phase method  -------------------//

function void tb::build_phase(uvm_phase phase);
    //get configuration object ram_env_config from database using uvm_config_db()
        if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

        //if ram_env_config parameter has_wagent=1
        //set m_cfg.m_wr_cfg into config database "ram_wr_agent_config" using uvm_config_db
    //create instance for ram_wr_agt_top
          if(e_cfg.has_apbagent==1)
                begin
        uvm_config_db #(apb_agent_config)::set(this,"*","apb_agent_config",e_cfg.apb_cfg);
        apb_agent_top=apb_agt_top::type_id::create("apb_agent_top",this);
                end
         if(e_cfg.has_spiagent==1)
                begin
        uvm_config_db #(spi_agent_config)::set(this,"*","spi_agent_config",e_cfg.spi_cfg);
        spi_agent_top=spi_agt_top::type_id::create("spi_agent_top",this);
                end
        if(e_cfg.has_scoreboard ==1)
                begin
//      uvm_config_db #(env_config)::set(this, "*", "env_config", e_cfg.sb);
        sb=scoreboard::type_id::create("sb", this);
                end
    super.build_phase(phase);

endfunction

function void tb::connect_phase(uvm_phase phase);

                if(e_cfg.has_scoreboard)
                  begin
                                apb_agent_top.agent[0].monh.mp.connect(sb.fifo_apb[0].analysis_export);
                                spi_agent_top.agent[0].monh.mp.connect(sb.fifo_spi[0].analysis_export);

                  end
endfunction
