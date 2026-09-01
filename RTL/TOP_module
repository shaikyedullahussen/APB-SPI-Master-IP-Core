module Top_module(
    input pclk,
    input preset_n,
    input  [2:0] paddr,
    input  pwrite,
    input  psel,
    input  penable,
    input  [7:0] pwdata,
    input miso,
    output ss,
    output sclk,
    output  spi_inter_req,
    output mosi,
    output  [7:0] prdata,
    output  pready,
    output  pslverr
    );

wire [7:0]data_miso;
wire [7:0]data_mosi;
wire send_data,receive_data;
wire [1:0]spi;
wire tip;

wire mstr,cpol,cphas,lsbfe,spiswai;
wire [2:0]sppr,spr;
wire [11:0]baudrate_div;
wire miso_receive_sclk;
wire miso_receive_sclk1;
wire mosi_send_sclk;
wire mosi_send_sclk1;


baudrate_generator uut (
  .pclk(pclk), 
  .preset_n(preset_n), 
  .spi(spi), 
  .spiswai(spiswai), 
  .sppr(sppr), 
  .spr(spr), 
  .cpol(cpol), 
  .cphas(cphas), 
  .ss(ss), 
  .sclk(sclk), 
  .miso_receive_sclk1(miso_receive_sclk1), 
  .miso_receive_sclk(miso_receive_sclk), 
  .mosi_send_sclk1(mosi_send_sclk1), 
  .mosi_send_sclk(mosi_send_sclk), 
  .baudrate_div(baudrate_div)
 );
 
spi_slave_control_select uut1(
  .pclk(pclk), 
  .preset_n(preset_n), 
  .mstr(mstr), 
  .spi(spi), 
  .spiswai(spiswai), 
  .send_data(send_data), 
  .baudrate_div(baudrate_div), 
  .receive_data(receive_data), 
  .ss(ss), 
  .tip(tip)
 );
 
shift_register uut2(
  .pclk(pclk), 
  .preset_n(preset_n), 
  .ss(ss), 
  .send_data(send_data), 
  .lsbfe(lsbfe), 
  .cphas(cphas), 
  .cpol(cpol), 
  .miso_receive_sclk(miso_receive_sclk), 
  .miso_receive_sclk1(miso_receive_sclk1), 
  .mosi_send_sclk(mosi_send_sclk), 
  .mosi_send_sclk1(mosi_send_sclk1), 
  .data_mosi(data_mosi), 
  .miso(miso), 
  .receive_data(receive_data), 
  .mosi(mosi), 
  .data_miso(data_miso)
 );
 
APB_slave_interface uut3 (
  .pclk(pclk), 
  .preset_n(preset_n), 
  .paddr(paddr), 
  .pwrite(pwrite), 
  .psel(psel), 
  .penable(penable), 
  .pwdata(pwdata), 
  .ss(ss), 
  .data_miso(data_miso), 
  .receive_data(receive_data), 
  .tip(tip), 
  .prdata(prdata), 
  .mstr(mstr), 
  .cpol(cpol), 
  .cphas(cphas), 
  .lsbfe(lsbfe), 
  .spiswai(spiswai), 
  .sppr(sppr), 
  .spr(spr), 
  .spi_inter_req(spi_inter_req), 
  .pready(pready), 
  .pslverr(pslverr), 
  .send_data(send_data), 
  .data_mosi(data_mosi), 
  .spi(spi)
 );


endmodule
