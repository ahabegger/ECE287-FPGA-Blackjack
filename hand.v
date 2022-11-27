module hand(
input [7:0]card_1,
input [7:0]card_2,
output reg [7:0]value1,
output reg [7:0]value2
);

always@(*)
begin 
	value1 = card_1 + card_2; 
	value2 = card_1 + card_2;

	if ((card_1 == 8'd1) + (card_2 == 8'd1))
		value1 = value1 + 8'd10;

end

endmodule