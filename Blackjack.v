module Blackjack(
	input rst,
	input clk,
	input start,
	input hit,
	input stand,
	input increment_1,
	input increment_5,
	input increment_10,
	input increment_25,
	output [6:0]seg7_neg_sign,
	output [6:0]seg7_dig0,
	output [6:0]seg7_dig1,
	output [6:0]seg7_dig2,
	output [6:0]seg7_dig3,
	output [6:0]seg7_dig4
);

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


// Defining Dealer Card Value
wire [7:0]dvalue;
wire [7:0]dcardsnum;

// Dealer Cards Initiated
wire [7:0]dcard1;
wire [7:0]dcard2;
wire [7:0]dcard3;
wire [7:0]dcard4;
wire [7:0]dcard5;

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
	      C_2: if (hit)
				   NS = C_3;
				  else if (stand) 
				   NS = DEAL;
	      C_3: if (value > 8'd21)
					NS = BUST;
				  else if (hit == 1'b1)
					NS = C_4;
				  else if (stand == 1'b1)
					NS = DEAL;
	      C_4: if (value > 8'd21)
					NS = BUST;
				  else if (hit == 1'b1)
					NS = C_5;
				  else if (stand == 1'b1)
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
			if (increment_1)
				bet = bet + 8'd1;
			if (increment_5)
				bet = bet + 8'd5;
			if (increment_10)
				bet = bet + 8'd10;
			if (increment_25)
				bet = bet + 8'd25;
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


endmodule
