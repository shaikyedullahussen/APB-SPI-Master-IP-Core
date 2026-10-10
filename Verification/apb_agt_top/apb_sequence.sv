
class apb_seqs extends uvm_sequence #(apb_xtn);
        `uvm_object_utils(apb_seqs)
        function new(string name="apb_seqs");
                super.new(name);
        endfunction
endclass

class apb_cpol0_cpha0_lsb1 extends apb_seqs;
        `uvm_object_utils(apb_cpol0_cpha0_lsb1)
        function new(string name="apb_cpol0_cpha0_lsb1");
                super.new(name);
        endfunction
        //CR1

        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {req.paddr==0;req.pwrite==1;req.pwdata==8'b11110001;});
                finish_item(req);

        //CR2
                start_item(req);
                assert(req.randomize with {req.paddr==1;req.pwrite==1;req.pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {req.paddr==2;req.pwrite==1;req.pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==1;req.pwdata==8'b11110001;});
                finish_item(req);

        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);
        endtask

endclass



class apb_cpol0_cpha1_lsb1 extends apb_seqs;
        `uvm_object_utils(apb_cpol0_cpha1_lsb1)
        function new(string name="apb_cpol0_cpha1_lsb1");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11110101;});
                finish_item(req);

        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11110101;});
                finish_item(req);
  #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass



class apb_cpol1_cpha0_lsb1 extends apb_seqs;
        `uvm_object_utils(apb_cpol1_cpha0_lsb1)
        function new(string name="apb_cpol1_cpha0_lsb1");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11111001;});
                finish_item(req);

        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11111001;});
                finish_item(req);

        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass


class apb_cpol1_cpha1_lsb1 extends apb_seqs;
        `uvm_object_utils(apb_cpol1_cpha1_lsb1)
        function new(string name="apb_cpol1_cpha1_lsb1");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11111101;});
                finish_item(req);

        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11111101;});
                finish_item(req);
        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass


//--------------------------------------------lsb0-----------------------

class apb_cpol0_cpha0_lsb0 extends apb_seqs;
        `uvm_object_utils(apb_cpol0_cpha0_lsb0)
        function new(string name="apb_cpol0_cpha0_lsb0");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11110000;});
                finish_item(req);

        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);
        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11110001;});
                finish_item(req);
        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass




class apb_cpol0_cpha1_lsb0 extends apb_seqs;
        `uvm_object_utils(apb_cpol0_cpha1_lsb0)
        function new(string name="apb_cpol0_cpha1_lsb0");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11110100;});
                finish_item(req);
        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);
        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11110100;});
                finish_item(req);
        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass



class apb_cpol1_cpha0_lsb0 extends apb_seqs;
        `uvm_object_utils(apb_cpol1_cpha0_lsb0)
        function new(string name="apb_cpol1_cpha0_lsb0");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11111000;});
                finish_item(req);
        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11111000;});
                finish_item(req);

        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass


class apb_cpol1_cpha1_lsb0 extends apb_seqs;
        `uvm_object_utils(apb_cpol1_cpha1_lsb0)
        function new(string name="apb_cpol1_cpha1_lsb0");
                super.new(name);
        endfunction
        //CR1
        task body();
                req=apb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize with {paddr==0;pwrite==1;pwdata==8'b11111100;});
                finish_item(req);
        //CR2
                start_item(req);
                assert(req.randomize with {paddr==1;pwrite==1;pwdata==8'b00000000;});
                finish_item(req);

        //BR
                start_item(req);
                assert(req.randomize with {paddr==2;pwrite==1;pwdata==8'b00010001;});
                finish_item(req);

        //DR
                start_item(req);
                assert(req.randomize with {paddr==5;pwrite==1;pwdata==8'b11111100;});
                finish_item(req);
        #1500;
                start_item(req);
                assert(req.randomize with {req.paddr==5;req.pwrite==0;});
                finish_item(req);

        endtask

endclass
