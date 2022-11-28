module Blackjack(
	input rst,
	input clk,
	input start,
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


// Defining State and Next State
reg [5:0]S;
reg [5:0]NS;

// Defining Parameters
parameters  INIT =     6'b000000;
				START =    6'b000001;
				BET =      6'b000010;
				C_2 =      6'b000011;
				C_3 =      6'b000100;
				C_4 =      6'b000101;
				C_5 =      6'b000110;
				BJ_5 =     6'b000111;
				BUST =     6'b001000;
				DEAL =     6'b001001;
				DEAL_BJ =  6'b001010;
				DEAL_BUST= 6'b001011;
				DEAL_TIE = 6'b001100;
				DEAL_HIGH= 6'b001101;
				DEAL_LOW = 6'b001110;
				LOST =     6'b001111;
				TIE =      6'b010000;
				WIN =      6'b010001;

// Handle State Conditions
always@(*)
case(S):
	     INIT:
	    START: if (!start)
					NS = BET;
			BET: if (start)
					NS = C_2;
	      C_2:
	      C_3:
	      C_4:
	      C_5:
	     BJ_5:
	     BUST:
	     DEAL:
	  DEAL_BJ:
	DEAL_BUST:
	 DEAL_TIE:
	DEAL_HIGH:
	 DEAL_LOW:
	     LOST:
	      TIE:
	      WIN:
	  default: NS = INIT;
endcase

// Reset Condition and Next State Condition
always@(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		S <= INIT;
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

endmodule


/* Instantiate Starter Money */
/*wire [7:0]total_money = 8'd200;
reg [7:0]bet = 8'd0;
*/
/* Displays Total Money */
//three_decimal_vals_w_neg TOTAL(total_money, seg7_neg_sign, seg7_dig0, seg7_dig1, seg7_dig2);

/* Displays Bet */
//two_decimal_vals BET(bet, seg7_dig3, seg7_dig4);
/*
always@(*)
begin
*/
	/* Increment Bet Amounts */
	/*if (increment_1)
		bet = bet + 8'd1;
	if (increment_5)
		bet = bet + 8'd5;
	if (increment_10)
		bet = bet + 8'd10;
	if (increment_25)
		bet = bet + 8'd25;
		*/
	/* Creates 99 Bet Ceiling */
	/*if (bet > 8'd99)
		bet = 8'd99;
		
end
endmodule
*/