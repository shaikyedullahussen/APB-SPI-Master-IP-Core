
class env_config extends uvm_object;


        // UVM Factory Registration Macro
        `uvm_object_utils(env_config)
        bit has_apbagent = 1;
        bit has_spiagent = 1;
        bit has_scoreboard = 1;
        apb_agent_config apb_cfg;
        spi_agent_config spi_cfg;

        int no_of_apb_agents = 1;
        int no_of_spi_agents = 1;
        reg_block reg_model;


        extern function new(string name = "env_config");

endclass: env_config
//-----------------  constructor new method  -------------------//

function env_config::new(string name = "env_config");
  super.new(name);
endfunction
