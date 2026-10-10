
class apb_xtn extends uvm_sequence_item;
        `uvm_object_utils(apb_xtn)
        function new(string name="apb_xtn");
                super.new(name);
        endfunction

        bit presetn;
        bit pclk;
        bit penable;
        bit psel;
        bit [7:0]prdata;
        rand bit pready;
        bit pselver;
        rand bit pwrite;
        rand bit [2:0]paddr;
        rand bit [7:0]pwdata;

        //constraint
        constraint c1{if(pwrite)
                        paddr inside{0,1,2,5};
                      else
                        paddr inside{0,1,2,3,5};}
        //do_print
        function void do_print(uvm_printer printer);
                printer.print_field("reset",presetn,1,UVM_BIN);
                printer.print_field("pclk",pclk,1,UVM_BIN);
                printer.print_field("penable",penable,1,UVM_BIN);
                printer.print_field("psel",psel,1,UVM_BIN);
                printer.print_field("pready",pready,1,UVM_BIN);
                printer.print_field("pselver",pselver,1,UVM_BIN);
                printer.print_field("pwrite",pwrite,1,UVM_BIN);
                printer.print_field("paddr",paddr,8,UVM_BIN);
                printer.print_field("pwdata",pwdata,8,UVM_BIN);
                printer.print_field("prdata",prdata,8,UVM_BIN);

        endfunction

endclass
