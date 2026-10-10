
class spi_agt_top extends uvm_env;

        `uvm_component_utils(spi_agt_top)

        spi_agent agent[];
//      env_config e_cfg;
        int no_of_agnt;
        extern function new(string name = "spi_agt_top" , uvm_component parent);
        extern function void build_phase(uvm_phase phase);
//      extern task run_phase(uvm_phase phase);
endclass

function spi_agt_top::new(string name = "spi_agt_top" , uvm_component parent);
        super.new(name,parent);
endfunction


function void spi_agt_top::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(int)::get(this,"","int",no_of_agnt))
                `uvm_fatal("fail","in spi_agent_top")
        agent=new[no_of_agnt];
        foreach(agent[i])
        agent[i]=spi_agent::type_id::create($sformatf("agent[%0d]",i),this);
endfunction
