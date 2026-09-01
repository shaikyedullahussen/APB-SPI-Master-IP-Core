module baudrate_generator(
  input pclk,
    input preset_n,
    input [1:0]spi,
    input spiswai,
    input [2:0]sppr,spr,
    input cpol,
    input cphas,
    input ss,
    output reg sclk,
    output reg miso_receive_sclk1,
    output reg miso_receive_sclk,
    output reg mosi_send_sclk1,
    output reg mosi_send_sclk,
    output  [11:0]baudrate_div
    );
  wire pre_sclk;
  reg [11:0]count;

assign baudrate_div=((sppr+1)*(2**(spr+1)));
assign pre_sclk=(cpol)?1'b1:1'b0;

/*always@(posedge pclk or negedge preset_n)
begin 
   if(!preset_n)
    begin
    sclk<=pre_sclk;
  count<=0;
  end
  else if (!ss && !spiswai && (spi_mode == 2'b00 || spi_mode == 2'b01))
    begin 
       if (count==((baudrate_div/2)-1))
        begin
        sclk<=~sclk;
      count<=0;
     end
    else 
       begin
         sclk<=sclk;
       count<=count+1'b1;
     end
   end
  else begin
      sclk<=pre_sclk;
    count<=0;
      end
end*/



//count
always@(posedge pclk or negedge preset_n)
begin
   if(!preset_n)
   count<=0;
 else if (!ss && !spiswai && (spi == 2'b00 || spi == 2'b01))
     begin
      if(count==((baudrate_div/2)-1))
       count<=0;
    else 
       count<=count+1'b1;
   end
 else 
    count<=0;
end

//sclk
always@(posedge pclk or negedge preset_n)
begin
    if(!preset_n)
    begin
    sclk<=pre_sclk;
  end
  else if (!ss && !spiswai && (spi == 2'b00 || spi == 2'b01))
    begin 
       if (count==((baudrate_div/2)-1))
        begin
        sclk<=~sclk;
     end
    else 
       begin
         sclk<=sclk;
     end
   end
  else begin
      sclk<=pre_sclk;
      end
end

//miso receive sclk
always@(posedge pclk or  negedge preset_n)
begin
   if(!preset_n)
     begin
     miso_receive_sclk<=1'b0;
   miso_receive_sclk1<=1'b0;
   end
 else if((!cphas && cpol)||(!cpol && cphas))
    begin
     if(sclk)
      begin
       if(count==((baudrate_div/2)-1))

         miso_receive_sclk1<=1'b1;
     else
         miso_receive_sclk1<=1'b0;
    end
   else 
      miso_receive_sclk1<=1'b0;
  end
 else
     begin
      if(!sclk)
      begin
       if(count==((baudrate_div/2)-1))

         miso_receive_sclk<=1'b1;
     else
         miso_receive_sclk<=1'b0;
    end
   else 
      miso_receive_sclk<=1'b0;
  end
end

//mosi send sclk
always@(posedge pclk or  negedge preset_n)
begin
   if(!preset_n)
     begin
     mosi_send_sclk<=1'b0;
   mosi_send_sclk1<=1'b0;
   end
 else if((!cphas && cpol)||(!cpol && cphas))
    begin
     if(sclk)
      begin
       if(count==((baudrate_div/2)-2))

         mosi_send_sclk1<=1'b1;
     else
         mosi_send_sclk1<=1'b0;
    end
   else 
      mosi_send_sclk1<=1'b0;
  end
 else
     begin
      if(!sclk)
      begin
       if(count==((baudrate_div/2)-2))
        mosi_send_sclk<=1'b1;
     else
         mosi_send_sclk<=1'b0;
    end
   else 
      mosi_send_sclk<=1'b0;
  end
end
    

endmodule
