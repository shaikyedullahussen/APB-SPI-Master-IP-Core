
class spi_driver extends uvm_driver #(spi_xtn);


        `uvm_component_utils(spi_driver)
        virtual spi_if.SPIDR_MP vif;
        spi_agent_config spi_cfg;
        bit cpha;
        bit cpol;
        bit lsb;
        bit [7:0] ctrl;

function new(string name = "spi_driver",uvm_component parent);
        super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_cfg))
                `uvm_fatal("CONFIG","cannot get() spi_cfg from uvm_config_db. Have you set() it?")

endfunction


  function void connect_phase(uvm_phase phase);
        vif=spi_cfg.vif;
  endfunction

task run_phase(uvm_phase phase);
        forever
                begin
                seq_item_port.get_next_item(req);
//      $display("**************************************");
//      req.print();

                send_to_dut(req);
                seq_item_port.item_done();
                end
endtask

task send_to_dut(spi_xtn xtn);
        if(!uvm_config_db #(bit[7:0])::get(this,"","bit[7:0]",ctrl))
        `uvm_fatal(get_type_name(),"cannot get ctrl")
        cpha = ctrl[2];
        cpol = ctrl[3];
        lsb = ctrl[0];
        wait (!vif.spi_drv_cb.ss);

        if(!cpha)
         vif.spi_drv_cb.miso <= xtn.miso [lsb ? 0:7];
        for(int i=(cpha? 0:1); i<8; i++)
         begin
          if(cpha ^ cpol)begin

                @(posedge vif.spi_drv_cb.sclk);
                end
          else begin

                @(negedge vif.spi_drv_cb.sclk);

                end
           vif.spi_drv_cb.miso <= xtn.miso [lsb ? i:(7-i)];
//      xtn.mosi=vif.spi_drv_cb.mosi;
         end
        $display("Driver finished");
        `uvm_info("SPI_DRIVER",$sformatf("printing from spi_driver \n %s", xtn.sprint()),UVM_LOW)
        $display("spi_driver :sclk=%b ss=%b miso=%0b", xtn.sclk,xtn.ss,xtn.miso);

endtask

endclass
