class apb_driver extends uvm_driver #(apb_xtn);


        `uvm_component_utils(apb_driver)

        apb_agent_config apb_cfg;
        virtual apb_if.apb_drv_cb vif;
   function new(string name = "apb_driver",uvm_component parent);
        super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
                `uvm_fatal("error","get_type_name()");
   endfunction

  function void connect_phase(uvm_phase phase);
        vif=apb_cfg.vif;
  endfunction

 task reset_dut();
        @(vif.apb_drv);
        vif.apb_drv.presetn<=1'b0;
        @(vif.apb_drv);
        vif.apb_drv.presetn<=1'b1;
endtask

 task run_phase(uvm_phase phase);
    reset_dut();

        forever
                begin
                seq_item_port.get_next_item(req);
                send_to_dut(req);
                seq_item_port.item_done();
                end
 endtask


 task send_to_dut(apb_xtn xtn);

        @(vif.apb_drv);
        //setup phase
        vif.apb_drv.psel<=1'b1;
        vif.apb_drv.penable<=1'b0;
        vif.apb_drv.paddr<=xtn.paddr;
        vif.apb_drv.pwrite<=xtn.pwrite;
        if(xtn.pwrite==1)
                vif.apb_drv.pwdata<=xtn.pwdata;

        //access phase
        @(vif.apb_drv);
                vif.apb_drv.penable<=1'b1;

        wait(vif.apb_drv.pready)


        begin
        if(xtn.pwrite==0)
                xtn.prdata=vif.apb_drv.prdata;
        end
        @(vif.apb_drv);

                vif.apb_drv.psel<=1'b0;
                vif.apb_drv.penable<=1'b0;
    `uvm_info("APB_DRIVER",$sformatf("printing from apb_driver \n %s", xtn.sprint()),UVM_LOW)
        $display("driver :Paddr=%0d pwrite=%0b pwdata=%0h", xtn.paddr,xtn.pwrite,xtn.pwdata);

        //xtn.print();
 endtask
endclass
