module player(
input clk,
input rst,
input deal,
input [15:0]random_seed,
input new_random_seed,
output [7:0]card1, 
output [7:0]card2, 
output [7:0]card3, 
output [7:0]card4, 
output [7:0]card5, 
output reg [31:0]val2, 
output reg [31:0]val3, 
output reg [31:0]val4, 
output reg [31:0]val5,
output reg [4:0]aces
);

// Card Value
integer cardval1;
integer cardval2;
integer cardval3;
integer cardval4;
integer cardval5;

// Card Value Holder
integer cardval1_holder;
integer cardval2_holder;
integer cardval3_holder;
integer cardval4_holder;
integer cardval5_holder;

random PDEAL(clk, rst, deal, random_seed, new_random_seed, card1, card2, card3, card4, card5);

always@(*)
begin 
	/*
	Defining Card Logic (1-52)
	Suit Order : Hearts, Diamonds, Clubs, Spades
	8'd0 - Ace (Hearts)
	8'd1 - 2 (Hearts)
	8'd2 - 3 (Hearts)
	8'd3 - 4 (Hearts)
	8'd4 - 5 (Hearts)
	8'd5 - 6 (Hearts)
	8'd6 - 7 (Hearts)
	8'd7 - 8 (Hearts)
	8'd8 - 9 (Hearts)
	8'd9 - 10 (Hearts)
	8'd10 - Jack (Hearts)
	8'd11 - Queen (Hearts)
	8'd12 - King (Hearts)
	8'd13 - Ace (Diamonds)
	8'd14 - 2 (Diamonds)
	8'd15 - 3 (Diamonds)
	8'd16 - 4 (Diamonds)
	8'd17 - 5 (Diamonds)
	8'd18 - 6 (Diamonds)
	8'd19 - 7 (Diamonds)
	8'd20 - 8 (Diamonds)
	8'd21 - 9 (Diamonds)
	8'd22 - 10 (Diamonds)
	8'd23 - Jack (Diamonds)
	8'd24 - Queen (Diamonds)
	8'd25 - King (Diamonds)
	8'd26 - Ace (Clubs)
	8'd27 - 2 (Clubs)
	8'd28 - 3 (Clubs)
	8'd29 - 4 (Clubs)
	8'd30 - 5 (Clubs)
	8'd31 - 6 (Clubs)
	8'd32 - 7 (Clubs)
	8'd33 - 8 (Clubs)
	8'd34 - 9 (Clubs)
	8'd35 - 10 (Clubs)
	8'd36 - Jack (Clubs)
	8'd37 - Queen (Clubs)
	8'd38 - King (Clubs)
	8'd39 - Ace (Spades)
	8'd40 - 2 (Spades)
	8'd41 - 3 (Spades)
	8'd42 - 4 (Spades)
	8'd43 - 5 (Spades)
	8'd44 - 6 (Spades)
	8'd45 - 7 (Spades)
	8'd46 - 8 (Spades)
	8'd47 - 9 (Spades)
	8'd48 - 10 (Spades)
	8'd49 - Jack (Spades)
	8'd50 - Queen (Spades)
	8'd51 - King (Spades)

	More Logic for Card Values:
	- Card_code % 13 + 1 == card_value
	- Aces = 1
	*/

	// Card Logic
	cardval1_holder = card1;
	cardval2_holder = card2;
	cardval3_holder = card3;
	cardval4_holder = card4;
	cardval5_holder = card5;
	
	cardval1 = (cardval1_holder % 13) + 1;
	cardval2 = (cardval2_holder % 13) + 1;
	cardval3 = (cardval3_holder % 13) + 1;
	cardval4 = (cardval4_holder % 13) + 1;
	cardval5 = (cardval5_holder % 13) + 1;
	
	
	// Face Card Logic
	if (cardval1 > 10)
		cardval1 = 10;
	if (cardval2 > 10)
		cardval2 = 10;
	if (cardval3 > 10)
		cardval3 = 10;
	if (cardval4 > 10)
		cardval4 = 10;
	if (cardval5 > 10)
		cardval5 = 10;
	
	// Defining Aces
	aces = {(cardval1 == 32'd1), 
			  (cardval2 == 32'd1),
			  (cardval3 == 32'd1),
			  (cardval4 == 32'd1), 
			  (cardval5 == 32'd1)};
	
	
	// Val2
	if (aces[0] || aces[1])
		val2 = cardval1 + cardval2 + 10;
	else 
		val2 = cardval1 + cardval2;
		
		
	// Val3
	if (aces[0] || aces[1] || aces[2])
	begin 
		if ((cardval1 + cardval2 + cardval3 + 10) > 21)
			val3 = cardval1 + cardval2 + cardval3;
		else
			val3 = cardval1 + cardval2 + cardval3 + 10;
	end
	else
		val3 = cardval1 + cardval2 + cardval3;
		
		
	// Val4
	if (aces[0] || aces[1] || aces[2] || aces[3])
	begin 
		if ((cardval1 + cardval2 + cardval3 + cardval4 + 10) > 21)
			val4 = cardval1 + cardval2 + cardval3 + cardval4;
		else
			val4 = cardval1 + cardval2 + cardval3 + cardval4 + 10;
	end
	else
		val4 = cardval1 + cardval2 + cardval3 + cardval4;
	
	
	// Val5
	if (aces[0] || aces[1] || aces[2] || aces[3] || aces[4])
	begin 
		if ((cardval1 + cardval2 + cardval3 + cardval4 + cardval5 + 10) > 21)
			val5 = cardval1 + cardval2 + cardval3 + cardval4 + cardval5;
		else
			val5 = cardval1 + cardval2 + cardval3 + cardval4 + cardval5 + 10;
	end
	else
		val5 = cardval1 + cardval2 + cardval3 + cardval4 + cardval5;
	
end


endmodule
