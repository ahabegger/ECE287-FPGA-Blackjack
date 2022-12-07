module Blackjack(
	input rst,
	input clk,
	input start,
	input [15:0]random_seed, // SW[0] - SW[15]
	input new_random_seed, 
	input key1, // KEY[0] -> PIN_M23
	input key2, // KEY[1] -> PIN_M21
	input key3, // KEY[2] -> PIN_N21
	input key4, // KEY[3] -> PIN_R24
	output [6:0]seg7_dig1, // HEX[0]
	output [6:0]seg7_dig2, // HEX[1]
	output [6:0]seg7_dig3, // HEX[2]
	output [6:0]seg7_dig4, // HEX[3]
	output [6:0]seg7_dig5, // HEX[4]
	output [6:0]seg7_dig6, // HEX[5]
	output [6:0]seg7_dig7, // HEX[6]
	output [6:0]seg7_dig8  // HEX[7]
);


// Defining Round Deal
reg deal;

// Defining Money Variables
reg  [7:0]bet;
wire [7:0]total_money;

// Defining Player Card Value
reg  [7:0]value;
wire [7:0]val2;
wire [7:0]val3;
wire [7:0]val4;
wire [7:0]val5;

// Player Cards Initiated
wire [7:0]card1;
wire [7:0]card2;
wire [7:0]card3;
wire [7:0]card4;
wire [7:0]card5;

// Deal Player Cards
player PLAYER(clk, rst, deal, random_seed, new_random_seed, card1, card2, card3, card4, card5, val2, val3, val4, val5);

// Defining Dealer Card Value
wire [7:0]dvalue;
wire [7:0]dcardsnum;

// Dealer Cards Initiated
wire [7:0]dcard1;
wire [7:0]dcard2;
wire [7:0]dcard3;
wire [7:0]dcard4;
wire [7:0]dcard5;

// Deal Dealer Logic
dealer DEALER(clk, rst, deal, {random_seed[2:0], random_seed[15:6], random_seed[2:0]}, new_random_seed, dcard1, dcard2, dcard3, dcard4, dcard5, dvalue, dcardsnum);

// Defining Output Variables
reg  win;
reg  tie;

// Defining State and Next State
reg  [5:0]S;
reg  [5:0]NS;

// Defining Parameters
parameter   INITS = 6'b000000,
				START = 6'b000001,
				BET = 6'b000010,
				C_2 = 6'b000011,
				C_3 = 6'b000100,
				C_4 = 6'b000101,
				C_5 = 6'b000110,
				BJ_5 = 6'b000111,
				BUST = 6'b001000,
				DEAL = 6'b001001,
				DEAL_BJ = 6'b001010,
				DEAL_BUST = 6'b001011,
				DEAL_TIE = 6'b001100,
				DEAL_HIGH = 6'b001101,
				DEAL_LOW = 6'b001110,
				LOST = 6'b001111,
				TIE = 6'b010000,
				WIN = 6'b010001;

// Handle State Conditions
always@(*)
case(S)
	    INITS: NS = START;
	    START: if (!start)
					NS = BET;
			BET: if (start)
					NS = C_2;
	      C_2: if (key3) // key3 == hit
				   NS = C_3;
				  else if (key2) // key2 == stand
				   NS = DEAL;
	      C_3: if (value > 8'd21)
					NS = BUST;
				  else if (key3 == 1'b1)
					NS = C_4;
				  else if (key2 == 1'b1)
					NS = DEAL;
	      C_4: if (value > 8'd21)
					NS = BUST;
				  else if (key3 == 1'b1)
					NS = C_5;
				  else if (key2 == 1'b1)
					NS = DEAL;
	      C_5: if (value > 8'd21)
					NS = BUST;
				  else
					NS = BJ_5;
	     BJ_5: if ((dvalue == 8'd21) && (dcardsnum == 8'd2))
					NS = DEAL_BJ;
				  else 
				   NS = WIN;
	     BUST: NS = LOST;
	     DEAL: if((dvalue == 8'd21) && (dcardsnum == 8'd2))
					NS = DEAL_BJ;
				  else if (dvalue > 21)
				   NS = DEAL_BUST;
				  else if (value > dvalue)
					NS = DEAL_LOW;
				  else if (value == dvalue)
					NS = DEAL_TIE;
				  else 
					NS = DEAL_HIGH;
	  DEAL_BJ: if ((val2 == value) && (value == 8'd21))
					NS = TIE;
				  else
					NS = LOST;
	DEAL_BUST: NS = LOST;
	 DEAL_TIE: if (val2 == 8'd21)
					NS = WIN;
				  else
				   NS = TIE;
	DEAL_HIGH: NS = LOST;
	 DEAL_LOW: NS = WIN;
	     LOST: NS = START;
	      TIE: NS = START;
	      WIN: NS = START;
	  default: NS = INITS;
endcase

// Reset Condition and Next State Condition
always@(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		S <= INITS;
	else
	begin
		// Bet Listener
		if (S == BET)
		begin
			if (key1)
				bet = bet - 8'd5;
			if (key2)
				bet = bet - 8'd1;
			if (key3)
				bet = bet + 8'd1;
			if (key4)
				bet = bet + 8'd5;
		end 
		
		S <= NS;
		
	end
end


// Output Condition
always@(*)
case (S)
	START: begin 
			 win = win;
			 tie = tie;
			 end
	WIN: win = 1'b1;
	TIE: tie = 1'b1;
	LOST: win = 1'b0;
	default: begin 
				win = 1'b0;
				tie = 1'b0;
				end
endcase


// Display Modules
three_decimal_vals_w_neg MONEY(total_money, seg7_dig4, seg7_dig1, seg7_dig2, seg7_dig3);
two_decimal_vals BETS(bet, seg7_dig5, seg7_dig6);
two_decimal_vals STATE({2'b00, S}, seg7_dig7, seg7_dig8);

endmodule
