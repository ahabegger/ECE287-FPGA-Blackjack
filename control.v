module CONTROL(
   input[4:0] hand,
   input LOST,
   input WIN,
   input start,
   input rst,
   input clk2,
   
   output reg end_lcd,
   output[7:0] LCD_DATA,
	output LCD_RW,
	output reg LCD_EN,
	output LCD_RS
);

reg[1:0] v1;
reg[3:0] v2;
reg[22:0] c;
reg[5:0] count;
	reg[4:0] state, NS;
reg clk;
reg[7:0] data;
reg en;
reg rs;
reg rw;


assign LCD_RW=rw;
assign LCD_RS=rs;
assign LCD_DATA=data;

initial
	count <= 0;

always@(negedge rst or posedge clk)
begin
	if (!rst)
		state <= 0;
	else
		state <= NS;
end

always@ (posedge clk2)
	begin
		if (count==99)
			begin
			count<=0;
			clk=1;
			end
		else count<=count+1;
		
		if (count==50)
			clk<=0;
			
		if (count==0) LCD_EN <= 1'b1;
		if (count==98) LCD_EN <= 1'b0;
	end 
	
	always @(state, start)
begin
   c=0;
   NS=state;
   
   case (state)
        5'b00000:
           begin
	   if (start)
              NS = 5'b00001;
           else NS = 5'b00000;
           end
        5'b00001:
           begin
           NS = 5'b00010;
           c[0]=1'b1;
           end
        5'b00010:
           begin
           NS = 5'b00011;
           c[1]=1'b1;
           end
        5'b00011:
           begin
	   if (LOST)
              NS = 5'b00100;
	   else if (WIN)
              NS = 5'b01011;
                else NS = 5'b10011;
           c[2]=1'b1;
           end
        5'b00100:
           begin
           NS = 5'b00101;
           c[3]=1'b1;
           end
        5'b00101:
           begin
           NS = 5'b00110;
           c[4]=1'b1;
           end
        5'b00110:
           begin
           NS = 5'b00111;
           c[5]=1'b1;
           end
        5'b00111:
           begin
           NS = 5'b01000;
           c[6]=1'b1;
           end
        5'b01000:
           begin
           NS = 5'b01001;
           c[7]=1'b1;
           end
        5'b01001:
           begin
           NS = 5'b01010;
           c[8]=1'b1;
           end
        5'b01010:
           begin
           NS = 5'b10110;
           c[9]=1'b1;
           end
        5'b01011:
           begin
           NS = 5'b01100;
           c[10]=1'b1;
           end
        5'b01100:
           begin
           NS = 5'b01101;
           c[11]=1'b1;
           end
        5'b01101:
           begin
           NS = 5'b01110;
           c[12]=1'b1;
           end
        5'b01110:
           begin
           NS = 5'b01111;
           c[13]=1'b1;
           end
        5'b01111:
           begin
           NS = 5'b10000;
           c[14]=1'b1;
           end
        5'b10000:
           begin
           NS = 5'b10001;
           c[15]=1'b1;
           end
        5'b10001:
           begin
           NS = 5'b10010;
           c[16]=1'b1;
           end
        5'b10010:
           begin
           NS = 5'b10110;
           c[17]=1'b1;
           end
        5'b10011:
           begin
           NS = 5'b10100;
           c[18]=1'b1;
           end
        5'b10100:
           begin
           NS = 5'b10101;
           c[19]=1'b1;
           end
        5'b10101:
           begin
	   if (LOST)
              NS = 5'b00100;
	   else if (WIN)
              NS = 5'b01011;
                else NS = 5'b10011;
           c[20]=1'b1;
           end
        5'b10110:
           begin
           c[21]=1'b1;
           if (!rst)
              begin
              NS = 5'b10111;
              end
           else begin
                NS = 5'b10110;
                end
           end
        5'b10111:
           begin
           NS = 5'b00000;
           c[22]=1'b1;
           end
        default: NS = state;
	endcase
end

always@(c)
begin
   case (c)
      23'b0000000000000000000001:
         begin
             data=8'b0011100;
             rs=1'b0;
             rw=1'b0;
         end
      23'b0000000000000000000010:
         begin
             data=8'b00001100;
             rs=1'b0;
             rw=1'b0;
         end
      23'b0000000000000000000100:
         begin
             data=8'b00000110;
             rs=1'b0;
             rw=1'b0;
         end
      23'b0000000000000000001000:
         begin
             data=8'b11000000;
             rs=1'b0;
             rw=1'b0;
         end
      23'b0000000000000000010000:
         begin
             data=8'b01000100;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000000000100000:
         begin
             data=8'b01000101;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000000001000000:
         begin
             data=8'b01000110;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000000010000000:
         begin
             data=8'b01000101;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000000100000000:
         begin
             data=8'b01000001;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000001000000000:
         begin
             data=8'b11000000;
             rs=1'b0;
             rw=1'b0;
         end
      23'b0000000000010000000000:
         begin
            data=8'b01010110;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000000100000000000:
         begin
             data=8'b01001001;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000001000000000000:
         begin
             data=8'b01000011;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000010000000000000:
         begin
             data=8'b01010100;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000000100000000000000:
         begin
             data=8'b01001111;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000001000000000000000:
         begin
             data=8'b01010010;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000010000000000000000:
         begin
             data=8'b01011001;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0000100000000000000000:
         begin
             data=8'b00000010;
             rs=1'b0;
             rw=1'b0;
             v1=hand/10;
             v2=hand%10;
         end
      23'b0001000000000000000000:
         begin
             data=48+v1;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0010000000000000000000:
         begin
             data=48+v2;
             rs=1'b1;
             rw=1'b0;
         end
      23'b0100000000000000000000:
         begin
            end_lcd=1'b1;
         end
      23'b1000000000000000000000:
         begin
            end_lcd=1'b0;
            data=8'b00000001;
            rs=1'b0;
            rw=1'b0;
         end   
   endcase
   LCD_EN <= 1'b0;
end

endmodule
