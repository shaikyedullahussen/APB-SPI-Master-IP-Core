module shift_register(
    input pclk,
    input preset_n,
    input ss,
    input send_data,
    input lsbfe,
    input cphas,
    input cpol,
    input miso_receive_sclk,
    input miso_receive_sclk1,
    input mosi_send_sclk,
    input mosi_send_sclk1,
    input [7:0] data_mosi,
    input miso,
    input receive_data,
    output reg mosi,
    output [7:0] data_miso
    );
  reg [7:0]temp_reg;//receive
  reg [7:0]shift_register;//send
  reg [2:0]count,count1;//shiftcount
  reg [2:0]count2,count3;//tempcount
  
  
assign data_miso=(receive_data)?temp_reg:8'h00;//data_miso

//shift_register
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
       shift_register<=8'b0;
   else 
      begin
        if(send_data)
       shift_register<=data_mosi;
    else
       shift_register<=shift_register;
    end
   end
 
 
//receive count
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
      begin
       count2<=3'b000;
     count3<=3'b111;
    end
   else if(!ss)
      begin
       if((!cphas && cpol) || (cphas && !cpol))
       begin
        if(lsbfe)
         begin
          if(count2<=3'd7)
           begin
             if(miso_receive_sclk1)
              count2<=count2+1;
         end
        else
            count2<=3'd0;
       end
      else
         begin
          if(count3>=3'd0)
           begin
            if(miso_receive_sclk1)
             count3<=count3-1;
         end
        else
           count3<=3'd7;
       end
     end
    else
      begin
        if(lsbfe)
         begin
          if(count2<=3'd7)
           begin
             if(miso_receive_sclk)
              count2<=count2+1;
         end
        else
            count2<=3'd0;
       end
      else
         begin
          if(count3>=3'd0)
           begin
            if(miso_receive_sclk)
             count3<=count3-1;
         end
        else
           count3<=3'd7;
       end
     end
     end
   else
      begin
       count2<=count;
     count3<=count;
    end
    end

//temp[count2]/temp[count3]
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
      begin
         temp_reg<=8'b00;
    end
   else if(!ss)
      begin
       if((!cphas && cpol) || (cphas && !cpol))
       begin
        if(lsbfe)
         begin
          if(count2<=3'd7)
           begin
             if(miso_receive_sclk1)
              temp_reg[count2]<=miso;
         end
        else
            temp_reg[count2]<=1'b0;
      end
      else
         begin
          if(count3>=3'd0)
           begin
            if(miso_receive_sclk1)
             temp_reg[count3]<=miso;
         end
        else
        
           temp_reg[count3]<=1'b0;
       end
     end
    else
      begin
        if(lsbfe)
         begin
          if(count2<=3'd7)
           begin
             if(miso_receive_sclk)
              temp_reg[count2]<=miso;
         end
        else
            temp_reg[count2]<=3'd0;
       end
      else
         begin
          if(count3>=3'd0)
           begin
            if(miso_receive_sclk)
             temp_reg[count3]<=miso;
         end
        else
           temp_reg[count3]<=3'd7;
       end
     end
     end
   else
      begin
       temp_reg[count2]<=0;
     temp_reg[count3]<=0;
    end
    end

//count & count1
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
      begin
       count<=3'b000;
     count1<=3'b111;
    end
   else if(!ss)
begin
       if((!cphas && cpol) || (cphas && !cpol))
       begin
        if(lsbfe)
         begin
          if(count<=3'd7)
           begin
             if(mosi_send_sclk1)
              count<=count+1;
         end
        else
            count<=3'd0;
       end
      else
         begin
          if(count1>=3'd0)
           begin
            if(mosi_send_sclk1)
             count1<=count1-1;
         end
        else
           count1<=3'd7;
       end
     end
    else
      begin
        if(lsbfe)
         begin
          if(count<=3'd7)
           begin
             if(mosi_send_sclk)
              count<=count+1;
         end
        else
            count<=3'd0;
       end
      else
         begin
          if(count1>=3'd0)
           begin
            if(mosi_send_sclk)
             count1<=count1-1;
         end
        else
           count1<=3'd7;
       end
     end
     end
   else
      begin
       count<=0;
     count1<=0;
    end
    end
    
//mosi
always@(posedge pclk or negedge preset_n)
  begin
     if(!preset_n)
      mosi<=1'b0;
   else if(!ss)
      begin
       if((!cphas && cpol) || (cphas && !cpol))
       begin
        if(lsbfe)
         begin
          if(count<=3'd7)
           begin
             if(mosi_send_sclk1)
              mosi<=shift_register[count];
         end
        else
            mosi<=3'd0;
       end
      else
         begin
          if(count1>=3'd0)
           begin
            if(mosi_send_sclk1)
             mosi<=shift_register[count1];
         end
        else
           mosi<=3'd7;
       end
     end
    else
      begin
        if(lsbfe)
         begin
          if(count<=3'd7)
           begin
             if(mosi_send_sclk)
              mosi<=shift_register[count];
         end
       end
      else
         begin
          if(count1>=3'd0)
           begin
            if(mosi_send_sclk)
             mosi<=shift_register[count1];
         end
       end
     end
     end
    end
endmodule
