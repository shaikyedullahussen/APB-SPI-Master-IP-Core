
class spi_monitor extends uvm_monitor;

        `uvm_component_utils(spi_monitor)
        uvm_analysis_port#(spi_xtn)mp;
        spi_agent_config spi_cfg;
        virtual spi_if.SPIMON_MP vif;
        bit cpha;
        bit cpol;
        bit lsb;
        bit [7:0] ctrl;


function new(string name="spi_monitor",uvm_component parent);
        super.new(name,parent);
        mp=new("mp",this);
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
                        collect_data();
                end
 endtask

 task collect_data();
        spi_xtn xtn;
        int bit_idx;
        xtn=spi_xtn::type_id::create("xtn");

        if(!uvm_config_db#(bit [7:0])::get(this,"","bit[7:0]",ctrl))
                `uvm_fatal(get_type_name(),"cannot get cntrl")
        cpha=ctrl[2];
        cpol=ctrl[3];
        lsb=ctrl[0];

        wait(!vif.spi_mon_cb.ss);
        for(int i=0;i<8;i++)
                begin
                bit_idx=lsb?i:(7-i);
                if(cpha^cpol)
                        begin
                        @(negedge vif.spi_mon_cb.sclk);
                        end
                else
                        begin
                        @(posedge vif.spi_mon_cb.sclk);
                        end

                xtn.miso[bit_idx]=vif.spi_mon_cb.miso;
                xtn.mosi[bit_idx]=vif.spi_mon_cb.mosi;
                xtn.ss=vif.spi_mon_cb.ss;

                end
                `uvm_info("SPI_MONITOR",$sformatf("printing from spi_monitor \n %s", xtn.sprint()),UVM_LOW)
//      $display("spi_monitor :mosi %0d=%0b",i, xtn.mosi);
//      $display("spi_monitor :miso %0d=%0b",i, xtn.miso);
        mp.write(xtn);
 endtask
 endclass
