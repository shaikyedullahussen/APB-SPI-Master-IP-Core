class apb_monitor extends uvm_monitor;


        `uvm_component_utils(apb_monitor)
        uvm_analysis_port#(apb_xtn)mp;
        apb_agent_config m_apb_cfg;
        virtual apb_if.apb_mon_cb vif;

   function new(string name = "apb_monitor",uvm_component parent);
        super.new(name,parent);
        mp=new("mp",this);
   endfunction

  function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_apb_cfg))
                `uvm_fatal("error","get_type_name()");
   endfunction

  function void connect_phase(uvm_phase phase);
        vif=m_apb_cfg.vif;
  endfunction
  task run_phase(uvm_phase phase);

        forever

                begin
                        collect_data();
                end
 endtask

 task collect_data();
        apb_xtn xtn;

        xtn=apb_xtn::type_id::create("xtn");
        @( vif.apb_mon);

        wait(vif.apb_mon.penable && vif.apb_mon.pready)

        xtn.psel=vif.apb_mon.psel;
        xtn.penable=vif.apb_mon.penable;
        xtn.paddr=vif.apb_mon.paddr;
        xtn.pwrite=vif.apb_mon.pwrite;
        xtn.presetn=vif.apb_mon.presetn;
//      xtn.pready=vif.apb_mon.pready;

        @(vif.apb_mon);
        if(xtn.pwrite)
                xtn.pwdata=vif.apb_mon.pwdata;
        else
                xtn.prdata=vif.apb_mon.prdata;
        xtn.pready = vif.apb_mon.pready;
        xtn.pselver = vif.apb_mon.pselver;
    `uvm_info("APB_MONITOR",$sformatf("printing from apb_monitor \n %s", xtn.sprint()),UVM_LOW)
        $display("APB_MONITOR :Paddr=%0d pwrite=%0b pwdata=%0h", xtn.paddr,xtn.pwrite,xtn.pwdata);

        mp.write(xtn);

 endtask
endclass
