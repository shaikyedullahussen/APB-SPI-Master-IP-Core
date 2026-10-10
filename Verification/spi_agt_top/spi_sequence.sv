
class spi_seqs extends uvm_sequence #(spi_xtn);

        `uvm_object_utils(spi_seqs)

function new(string name ="spi_seqs");
        super.new(name);
endfunction

endclass


//cpol-0 , cphase-0 , lsb-1
class spi_cpol0_cpha0_lsb1 extends spi_seqs;
        `uvm_object_utils(spi_cpol0_cpha0_lsb1)
  function new(string name="spi_cpol0_cpha0_lsb1");
        super.new(name);
  endfunction

  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {miso == 8'b10101010;});
//      `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
//      req.print();

        finish_item(req);
  endtask
endclass

//cpol-0 , cphase-1 , lsb-1
class spi_cpol0_cpha1_lsb1 extends spi_seqs;
        `uvm_object_utils(spi_cpol0_cpha1_lsb1)
  function new(string name="spi_cpol0_cpha1_lsb1");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass

//cpol-1 , cphase-0 , lsb-1
class spi_cpol1_cpha0_lsb1 extends spi_seqs;
        `uvm_object_utils(spi_cpol1_cpha0_lsb1)
  function new(string name="spi_cpol1_cpha0_lsb1");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass

//cpol-1 , cphase-1 , lsb-1
class spi_cpol1_cpha1_lsb1 extends spi_seqs;
        `uvm_object_utils(spi_cpol1_cpha1_lsb1)
  function new(string name="spi_cpol1_cpha1_lsb1");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass


//cpol-0 , cphase-0 , lsb-0
class spi_cpol0_cpha0_lsb0 extends spi_seqs;
        `uvm_object_utils(spi_cpol0_cpha0_lsb0)
  function new(string name="spi_cpol0_cpha0_lsb0");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass

//cpol-0 , cphase-1 , lsb-0
class spi_cpol0_cpha1_lsb0 extends spi_seqs;
        `uvm_object_utils(spi_cpol0_cpha1_lsb0)
  function new(string name="spi_cpol0_cpha1_lsb0");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass

//cpol-1 , cphase-0 , lsb-0
class spi_cpol1_cpha0_lsb0 extends spi_seqs;
        `uvm_object_utils(spi_cpol1_cpha0_lsb0)
  function new(string name="spi_cpol1_cpha0_lsb0");
        super.new(name);
  endfunction
  task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
  endtask
endclass

//cpol-1 , cphase-1 , lsb-0
class spi_cpol1_cpha1_lsb0 extends spi_seqs;
        `uvm_object_utils(spi_cpol1_cpha1_lsb0)
  function new(string name="spi_cpol1_cpha1_lsb0");
        super.new(name);
  endfunction
 task body();
        req=spi_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {miso == 8'b10101010;});
//      `uvm_info("SPI_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
//      req.print();

        finish_item(req);
  endtask
endclass
