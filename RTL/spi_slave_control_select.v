module spi_slave_control_select(
    input pclk,
    input preset_n,
    input mstr,
    input [1:0] spi,
    input spiswai,
    input send_data,
    input [11:0]baudrate_div,
    output reg receive_data,
    output reg ss,
    output tip
    );
  reg rcv;
  wire [11:0]target;
  reg [15:0]count;
  
  assign target = (baudrate_div*8);
  
  //rcv
  always@(posedge pclk or negedge preset_n)
       begin
      if(!preset_n)
       rcv<=1'b0;
    else if (!spiswai && (spi==2'b00 || spi==2'b01) && mstr)
        begin
         if(!send_data)
          begin
          if(count<=(target-1'b1))
           begin
           if(count==(target-1'b1))
            rcv<=1'b1;
         else 
            rcv<=1'b0;
         end
        else 
           rcv<=1'b0;
       end
      else 
         rcv<=1'b0;
     end
     end      

//receive_data
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
     receive_data<=1'b0;
   else
      receive_data<=rcv;
  end
  
// ss and tip
assign tip = ~ss;
always@(posedge pclk or negedge preset_n)
       begin
      if(!preset_n)
       ss<=1'b1;
    else if (!spiswai && (spi==2'b00 || spi==2'b01) && mstr)
        begin
         if(!send_data)
          begin
          if(count<=(target-1'b1))
           ss<=1'b0;
        else 
         ss<=1'b1;
       end
      else 
           ss<=1'b0;
     end
     else 
      ss<=1'b1;
 end
           
//count 

always@(posedge pclk or negedge preset_n)
       begin
      if(!preset_n)
       count<=16'hffff;
    else if (!spiswai && (spi==2'b00 || spi==2'b01) && mstr)
        begin
         if(!send_data)
          begin
          if(count<=(target-1'b1))
           count<=count+1;
        else 
         count<=16'hffff;
       end
      else 
           count<=16'h0;
     end
     else 
      count<=16'hffff;
 end
           
endmodule
