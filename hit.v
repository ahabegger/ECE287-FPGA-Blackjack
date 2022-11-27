module hit(
input [7:0]before_value1,
input [7:0]before_value2,
input [7:0]card,
output reg [7:0]value1,
output reg [7:0]value2
);

always@(*)
begin 
	value1 = before_value1 + card;
	value2 = before_value2 + card;

	if ((card == 8'd1) & ((value1 + 8'd10) < 22))
		value1 = value1 + 8'd10;

end
endmodule
