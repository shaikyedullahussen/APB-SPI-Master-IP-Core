
class spi_xtn extends uvm_sequence_item;

`uvm_object_utils(spi_xtn)
function new(string name ="spi_trans");
        super.new(name);
endfunction

        bit sclk;
        bit ss;
        bit [7:0] mosi;
        rand bit [7:0] miso;

function void do_print(uvm_printer printer);
                printer.print_field("sclk", sclk,1,UVM_BIN);
                printer.print_field("ss",ss,1,UVM_BIN);
                printer.print_field("miso", miso,8,UVM_BIN);
                printer.print_field("mosi",mosi,8,UVM_BIN);
endfunction

endclass
