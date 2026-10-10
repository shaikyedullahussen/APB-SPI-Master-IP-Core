
class base_test extends uvm_test;

        `uvm_component_utils(base_test)

   tb envh;
   env_config e_cfg;
   apb_agent_config apb_cfg;
   spi_agent_config spi_cfg;

   bit has_apbagent=1;
   bit has_spiagent=1;
        int num=1;
//      bit [7:0]ctrl;

        reg_block reg_model;

function new(string name = "base_test" , uvm_component parent);
        super.new(name,parent);
endfunction



function void config_ram();
        if(has_apbagent)
                begin
                if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_vif",apb_cfg.vif))
                //$display("getting interface");
                        `uvm_fatal("APBVIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

                e_cfg.apb_cfg=apb_cfg;
                end
        if(has_spiagent)
                begin
                if(!uvm_config_db#(virtual spi_if)::get(this,"","spi_vif",spi_cfg.vif))
                        `uvm_fatal("SPIVIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

                e_cfg.spi_cfg=spi_cfg;
                end
                e_cfg.has_apbagent = has_apbagent;
                e_cfg.has_spiagent = has_spiagent;
        uvm_config_db#(int)::set(this,"*","int",num);
        uvm_config_db#(env_config)::set(this,"*","env_config",e_cfg);

endfunction



function void build_phase(uvm_phase phase);

        e_cfg=env_config::type_id::create("e_cfg");

    if(has_apbagent)
        begin
        apb_cfg=apb_agent_config::type_id::create("apb_cfg");
        end

    if(has_spiagent)
                begin
                spi_cfg=spi_agent_config::type_id::create("spi_cfg");
                end
    config_ram();
    super.build_phase(phase);
        envh=tb::type_id::create("envh",this);

        //creating instance for the reg block
        reg_model=reg_block::type_id::create("reg_model");
        reg_model.build();
        e_cfg.reg_model=this.reg_model;
endfunction


function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction
endclass
//-------------------------------------------------cp0_ch0_lsb1

class cp0_ch0_lsb1 extends base_test;
        `uvm_component_utils(cp0_ch0_lsb1)

        apb_cpol0_cpha0_lsb1 a001;
        spi_cpol0_cpha0_lsb1 s001;
        bit [7:0]ctrl=8'b11110001;



        function new(string name="cp0_ch0_lsb1",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

endfunction

        task run_phase(uvm_phase phase);
        //      super.run_phase(phase);

                phase.raise_objection(this);
                a001=apb_cpol0_cpha0_lsb1::type_id::create("a001");
                s001=spi_cpol0_cpha0_lsb1::type_id::create("s001");
                fork
                        a001.start(envh.apb_agent_top.agent[0].seqrh);
                        s001.start(envh.spi_agent_top.agent[0].seqrh);
                join
                        #500;
                phase.drop_objection(this);

        endtask
endclass


//-------------------------------------------------cp0_ch1_lsb1
class cp0_ch1_lsb1 extends base_test;
        `uvm_component_utils(cp0_ch1_lsb1)

        apb_cpol0_cpha1_lsb1 a011;
        spi_cpol0_cpha1_lsb1 s011;
        bit [7:0]ctrl=8'b11110101;


        function new(string name="cp0_ch1_lab1",uvm_component parent);
                super.new(name,parent);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                        a011=apb_cpol0_cpha1_lsb1::type_id::create("a011");
                        s011=spi_cpol0_cpha1_lsb1::type_id::create("s011");
        fork
                        a011.start(envh.apb_agent_top.agent[0].seqrh);
                        s011.start(envh.spi_agent_top.agent[0].seqrh);
        join
                phase.drop_objection(this);
        endtask
endclass




//-------------------------------------------------cp1_ch0_lsb1
class cp1_ch0_lsb1 extends base_test;
        `uvm_component_utils(cp1_ch0_lsb1)

        apb_cpol1_cpha0_lsb1 a101;
        spi_cpol1_cpha0_lsb1 s101;
        bit [7:0]ctrl=8'b11111001;

        function new(string name="cp1_ch0_lab1",uvm_component parent);
                super.new(name,parent);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                                a101=apb_cpol1_cpha0_lsb1::type_id::create("c101");
                                s101=spi_cpol1_cpha0_lsb1::type_id::create("s101");
                fork
                        a101.start(envh.apb_agent_top.agent[0].seqrh);
                        s101.start(envh.spi_agent_top.agent[0].seqrh);
                join
                phase.drop_objection(this);
        endtask
endclass



//-------------------------------------------------cp1_ch1_lsb1
class cp1_ch1_lsb1 extends base_test;
        `uvm_component_utils(cp1_ch1_lsb1)

        apb_cpol1_cpha1_lsb1 a111;
        spi_cpol1_cpha1_lsb1 s111;
        bit [7:0]ctrl=8'b11111101;


        function new(string name="cp1_ch1_lab1",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                                a111=apb_cpol1_cpha1_lsb1::type_id::create("a111");
                                s111=spi_cpol1_cpha1_lsb1::type_id::create("s111");
                fork
                        a111.start(envh.apb_agent_top.agent[0].seqrh);
                        s111.start(envh.spi_agent_top.agent[0].seqrh);
                join
                phase.drop_objection(this);
        endtask
endclass




//-------------------------------------------------cp0_ch0_lsb0
class cp0_ch0_lsb0 extends base_test;
        `uvm_component_utils(cp0_ch0_lsb0)

        apb_cpol0_cpha0_lsb0 a000;
        spi_cpol0_cpha0_lsb0 s000;
        bit [7:0]ctrl=8'b11110000;

        function new(string name="cp0_ch0_lsb0",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                a000=apb_cpol0_cpha0_lsb0::type_id::create("a000");
                s000=spi_cpol0_cpha0_lsb0::type_id::create("s000");
        fork
                        a000.start(envh.apb_agent_top.agent[0].seqrh);
                        s000.start(envh.spi_agent_top.agent[0].seqrh);
        join
                phase.drop_objection(this);
        endtask
endclass


//-------------------------------------------------cp0_ch1_lsb0
class cp0_ch1_lsb0 extends base_test;
        `uvm_component_utils(cp0_ch1_lsb0)

        apb_cpol0_cpha1_lsb0 a010;
        spi_cpol0_cpha1_lsb0 s010;
        bit [7:0]ctrl=8'b11110100;

        function new(string name="cp0_ch1_lsb0",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                        a010=apb_cpol0_cpha1_lsb0::type_id::create("a010");
                        s010=spi_cpol0_cpha1_lsb0::type_id::create("s010");
                fork
                        a010.start(envh.apb_agent_top.agent[0].seqrh);
                        s010.start(envh.spi_agent_top.agent[0].seqrh);
                join
                phase.drop_objection(this);
        endtask
endclass




//-------------------------------------------------cp1_ch0_lsb0
class cp1_ch0_lsb0 extends base_test;
        `uvm_component_utils(cp1_ch0_lsb0)

        apb_cpol1_cpha0_lsb0 a100;
        spi_cpol1_cpha0_lsb0 s100;
        bit [7:0]ctrl=8'b11111000;


        function new(string name="cp1_ch0_lsb0",uvm_component parent);
                super.new(name,parent);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                        a100=apb_cpol1_cpha0_lsb0::type_id::create("a100");
                        s100=spi_cpol1_cpha0_lsb0::type_id::create("s100");
                fork
                        a100.start(envh.apb_agent_top.agent[0].seqrh);
                        s100.start(envh.spi_agent_top.agent[0].seqrh);
                join
                phase.drop_objection(this);
        endtask
endclass



//-------------------------------------------------cp1_ch1_lsb0
class cp1_ch1_lsb0 extends base_test;
        `uvm_component_utils(cp1_ch1_lsb0)

        apb_cpol1_cpha1_lsb0 a110;
        spi_cpol1_cpha1_lsb0 s110;
        bit [7:0]ctrl=8'b11111100;

        function new(string name="cp1_ch1_lab0",uvm_component parent);
                super.new(name,parent);
                uvm_config_db#(bit [7:0])::set(this,"*","bit[7:0]",ctrl);

        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

        endfunction

        task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                        a110=apb_cpol1_cpha1_lsb0::type_id::create("a110");
                        s110=spi_cpol1_cpha1_lsb0::type_id::create("s110");
                fork
                        a110.start(envh.apb_agent_top.agent[0].seqrh);
                        s110.start(envh.spi_agent_top.agent[0].seqrh);
                join
                phase.drop_objection(this);
        endtask
endclass
