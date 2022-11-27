module draw(
input [7:0]random,
output [7:0]card_code,
output [1:0]suit_code
);

// Holder Integer
integer card_value;
integer suit_value;

/*
This module will generate a random card 
*/

always@(*)
begin 

	card_value = (random % 13) + 1; 
	suit_code = (random[7:5] % 4) + 1;

	card_code = card_value;
	suit_code = suit_value;
	
end
endmodule
