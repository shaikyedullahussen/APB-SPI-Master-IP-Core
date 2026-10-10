
class scoreboard extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)
        uvm_tlm_analysis_fifo#(apb_xtn)fifo_apb[];
        uvm_tlm_analysis_fifo#(spi_xtn)fifo_spi[];
        apb_xtn a_xtn;
        spi_xtn s_xtn;

        apb_xtn apb_cov_data;
        spi_xtn spi_cov_data;
        env_config e_cfg;

        reg_block reg_model;
          uvm_status_e  status_e;
          bit[7:0]  ctr1_reg;
          bit[7:0]  ctr2_reg;
          bit[7:0]  br_reg;
          bit[7:0]  sr_reg;
          bit[7:0]  dr_reg;




        function new(string name="scoreboard",uvm_component parent);
                super.new(name,parent);
                apb_cover_group = new;
                spi_cover_group = new;

        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                                `uvm_fatal(get_type_name(),"cannot get() e_cfg from uvm_config_db. Have you set() it?")
                fifo_apb=new[e_cfg.no_of_apb_agents];
                fifo_spi=new[e_cfg.no_of_spi_agents];

         foreach(fifo_apb[i])
                fifo_apb[i]=new($sformatf("fifo_apb[%0d]",i),this);
         foreach(fifo_spi[i])
                fifo_spi[i]=new($sformatf("fifo_spi[%0d]",i),this);

 //ASSIGNING REQ MODEL
     reg_model = e_cfg.reg_model;


//      $display("////////////");
        endfunction



 //RAL TASK
        task ral();
           reg_model.cr1_reg.read(status_e,ctr1_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
           `uvm_info("score_board-REGISTER1",$sformatf("CRT1_REG %h ",ctr1_reg),UVM_LOW)
         reg_model.cr2_reg.read(status_e,ctr2_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
           `uvm_info("score_board-REGISTER2",$sformatf("CRT2_REG %h ",ctr2_reg),UVM_LOW)
         reg_model.br_reg.read(status_e,br_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
         `uvm_info("score_board-REGISTER3",$sformatf("BR_REG %h ",br_reg),UVM_LOW)
          reg_model.sr_reg.read(status_e,sr_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
          `uvm_info("score_board-REGISTER4",$sformatf("SR_REG %h ",sr_reg),UVM_LOW)
         reg_model.dr_reg.read(status_e,dr_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
          `uvm_info("score_board-REGISTER5",$sformatf("DR_REG %h ",dr_reg),UVM_LOW)

  endtask

        task run_phase(uvm_phase phase);
                fork
                begin
                        forever
                                begin
                                fifo_apb[0].get(a_xtn);
                                `uvm_info(get_type_name(),$sformatf("printing from scoreboard :\n apb_xtn=\n %s", a_xtn.sprint()),UVM_LOW)
                                ral();

                                compare_data1();
                                end
                 end

                 begin
                        forever
                                  begin
                                fifo_spi[0].get(s_xtn);
                                `uvm_info(get_type_name(),$sformatf("printing from scoreboard :\n spi_xtn=\n %s", s_xtn.sprint()),UVM_LOW)
                        //      $display("before compare======================================================");
                                compare_data1();

                                ral();
                        //      $display("after compare======================================================");

                                  end
                end
                join
        endtask

        task compare_data1();
                wait(a_xtn !=null);
                wait(s_xtn !=null);
                if(a_xtn.pwrite && (a_xtn.paddr==3'b101))
                        begin
                                if(a_xtn.pwdata==s_xtn.mosi)
                                begin

                                        $display("\n\t\t*******MOSI COMPARISON*******\t\t");
                                        $display("pwrite = %0b\t\t\t",a_xtn.pwrite);
                                        $display("pwdata = %0b\t\t\t",a_xtn.pwdata);
                                        $display("MOSI =%0b\t\t\t",s_xtn.mosi);
                                        $display("\t\t*****COMPARISON SUCCESS*******\t\t\n");
                                end
                                else
                                        begin


                                        $display("\n\t\t*******MOSI COMPARISON*******\t\t");
                                        $display("pwrite = %0b\t\t\t",a_xtn.pwrite);
                                        $display("pwdata = %0b\t\t\t",a_xtn.pwdata);
                                        $display("MOSI =%0b\t\t\t",s_xtn.mosi);
                                        $display("\t\t***** COMPARISON FAILED*******\t\t\n");
                                        end
                        end
        /*endtask

        task compare_data2(apb_xtn xtn);
                wait(a_xtn !=null);
                wait(s_xtn !=null);*/

                 if((!a_xtn.pwrite) && (a_xtn.paddr == 3'b101))
                        begin
                                `uvm_info(get_type_name(),$sformatf("in between :\n spi_xtn=\n %s", a_xtn.sprint()),UVM_LOW)

                                $display("in between compare======================================================");

                        //      if(a_xtn.prdata!=0) begin
                                if(a_xtn.prdata == s_xtn.miso)
                                        begin
                                        $display("\n********************************************");
                                        $display("\n\t\t*******MISO COMPARISON*******\t\t");
                                        $display("pwrite = %0b\t\t\t",a_xtn.pwrite);
                                        $display("prdata = %0b\t\t\t",a_xtn.prdata);
                                        $display("MISO =%0b\t\t\t",s_xtn.miso);
                                        $display("\t\t*****COMPARISON SUCCESS*******\t\t\n");
                                        $display("********************************************\n");
                                        end
                                else
                                        begin
                                        $display("\n********************************************");
                                        $display("\n\t\t*******MISO COMPARISON*******\t\t");
                                        $display("pwrite = %0b\t\t\t",a_xtn.pwrite);
                                        $display("prdata = %0b\t\t\t",a_xtn.prdata);
                                        $display("MISO =%0b\t\t\t",s_xtn.miso);
                                        $display("\t\t******COMPARISON FAILED*******\t\t\n");
                                        $display("********************************************\n");
                                        end


                        end

 //COMPARING LOGICS FOR THE REGISTERS
        //================CR1===============
        if((a_xtn.paddr==0)&&(a_xtn.pwrite==1))
          begin
              if(a_xtn.pwdata==ctr1_reg)
                begin
                    $display("=============== CR1 REGISTER COMPARED SUCCESSFULL====================");
                    $display("CR1 DATA=%h ,a_xtn=%h ",ctr1_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                    $display("=============== CR1 REGISTER COMPARED FAILED====================");
                    $display("CR1 DATA=%h ,a_xtn=%h ",ctr1_reg,a_xtn.pwdata);
                    $display("====================================================");
                end


          end

        //================CR2===============
        if((a_xtn.paddr==1)&&(a_xtn.pwrite==1))
          begin
              if(a_xtn.pwdata==ctr2_reg)
                begin
                    $display("=============== CR2 REGISTER COMPARED SUCCESSFULL====================");
                    $display("CR2 DATA=%h ,a_xtn=%h ",ctr2_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                    $display("=============== CR2 REGISTER COMPARED FAILED====================");
                    $display("CR2 DATA=%h ,a_xtn=%h ",ctr2_reg,a_xtn.pwdata);
                    $display("====================================================");
                end

          end

       //================BR===============
        if((a_xtn.paddr==2)&&(a_xtn.pwrite==1))
          begin
              if(a_xtn.pwdata==br_reg)
                begin
                    $display("=============== BR REGISTER COMPARED SUCCESSFULL====================");
                    $display("BR DATA=%h ,a_xtn=%h ",br_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                    $display("=============== BR REGISTER COMPARED FAILED====================");
                    $display("BR DATA=%h ,a_xtn=%h ",br_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
          end

      //================SR===============
        if((a_xtn.paddr==3)&&(a_xtn.pwrite==1))
          begin
              if(a_xtn.pwdata==sr_reg)
                begin
                    $display("=============== SR REGISTER COMPARED SUCCESSFULL====================");
                    $display("SR DATA=%h ,a_xtn=%h ",sr_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                    $display("=============== SR REGISTER COMPARED FAILED====================");
                    $display("SR DATA=%h ,a_xtn=%h ",sr_reg,a_xtn.pwdata);
                    $display("====================================================");
                end


          end

      //================DR===============
        if((a_xtn.paddr==5)&&(a_xtn.pwrite==1))
          begin
              if(a_xtn.pwdata==dr_reg)
                begin
                    $display("=============== DR REGISTER COMPARED SUCCESSFULL====================");
                    $display("DR DATA=%h ,a_xtn=%h ",dr_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                    $display("=============== DR REGISTER COMPARED FAILED====================");
                    $display("DR DATA=%h ,a_xtn=%h ",dr_reg,a_xtn.pwdata);
                    $display("====================================================");
                end
          end

 endtask

  covergroup apb_cover_group;
   option.per_instance=1;
        reset : coverpoint apb_cov_data.presetn{bins rst={0,1};}
        address : coverpoint apb_cov_data.paddr{bins addr={0,1,2,3,5};}
        sel : coverpoint apb_cov_data.psel{bins sel={0,1};}
        enable : coverpoint apb_cov_data.penable{bins enb={0,1};}
        write : coverpoint apb_cov_data.pwrite{bins wrt={0,1};}
        ready : coverpoint apb_cov_data.pready{bins rdy={0,1};}
        wdata : coverpoint apb_cov_data.pwdata{bins wdata_low={[8'h00:8'h0f]};
                                               bins wdata_high={[8'h1f:8'hff]};}
        rdata : coverpoint apb_cov_data.prdata{bins rdata_low={[8'h00:8'h0f]};
                                               bins rdata_high={[8'h1f:8'hff]};}
  //cross

        sel_enable : cross sel,enable;
        sel_enable_ready : cross sel,enable,ready;

  endgroup

 covergroup spi_cover_group;
   option.per_instance=1;
   slave_select : coverpoint spi_cov_data.ss{bins ss={0,1};}
   miso_data    : coverpoint spi_cov_data.miso{bins miso_low={[8'h00:8'h0f]};
                                               bins miso_high={[8'h1f:8'hff]};}
   mosi_data    : coverpoint spi_cov_data.mosi{bins mosi_low={[8'h00:8'h0f]};
                                               bins mosi_high={[8'h1f:8'hff]};}

 endgroup

 endclass
