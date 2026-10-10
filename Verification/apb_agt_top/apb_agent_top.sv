
class apb_agt_top extends uvm_env;

        `uvm_component_utils(apb_agt_top)

       apb_agent agent[];
        int no_of_agnt;
        extern function new(string name = "apb_agt_top" , uvm_component parent);
        extern function void build_phase(uvm_phase phase);
endclass
function apb_agt_top::new(string name = "apb_agt_top" , uvm_component parent);
        super.new(name,parent);
endfunction


function void apb_agt_top::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(int)::get(this,"","int",no_of_agnt)))
                `uvm_fatal("fail","not getting data from base_test")
        agent=new[no_of_agnt];
        foreach(agent[i])
        agent[i]=apb_agent::type_id::create($sformatf("agent[%0d]",i),this);
endfunction
