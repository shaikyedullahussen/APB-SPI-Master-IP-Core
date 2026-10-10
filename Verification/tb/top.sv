
module top;

        // import ram_test_pkg
    import pck::*;
        //import uvm_pkg.sv
    import uvm_pkg::*;
        //include uvm_macros.sv

        `include "uvm_macros.svh"
        bit clock;
        always #5 clock = ~clock;

    apb_if in0(clock);
    spi_if in1(clock);
   spi_top_block spi_top(.pclk(in0.pclk),
                 .preset_n(in0.presetn),
                 .paddr_i(in0.paddr),
                 .pwrite_i(in0.pwrite),
                 .psel_i(in0.psel),
                 .penable_i(in0.penable),
                 .pwdata_i(in0.pwdata),
                 .prdata_o(in0.prdata),
                 .pready_o(in0.pready),
                 .pslverr_o(in0.pselver),
                 .sclk_o(in1.sclk),
                 .mosi_o(in1.mosi),
                 .ss_o(in1.ss),
                 .miso_i(in1.miso));

    // Generate clock signal


   initial
        begin
                        `ifdef VCS
                        $fsdbDumpvars(0, top);
                        `endif
        uvm_config_db #(virtual apb_if)::set(null,"*","apb_vif",in0);
        uvm_config_db #(virtual spi_if)::set(null,"*","spi_vif",in1);

        run_test();

        end

endmodule
