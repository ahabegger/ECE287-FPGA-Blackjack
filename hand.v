module hand(
input [7:0]card_1,
input [7:0]card_2,
output reg [7:0]value1,
output reg [7:0]value2, 
output reg [7:0]value3,
output reg [7:0]value4, 
output reg [7:0]value5,
output reg [7:0]value6
);

always@(*)
begin 
	value1 = card_1 + card_2; 
	value2 = card_1 + card_2;
	value3 = card_1 + card_2; 
	value4 = card_1 + card_2;
	value5 = card_1 + card_2; 
	value6 = card_1 + card_2;

	if ((card_1 == 8'd1) + (card_2 == 8'd1))
		value1 = value1 + 8'd10;

end

endmodule