module Blackjack(
	input rst, // PIN_Y24 SW[16]
	input clk, // PIN_Y2
	input [15:0]random_seed, // SW[0] - SW[15]
	input new_random_seed, //SW[17]
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
	output [6:0]seg7_dig8,  // HEX[7]
	output reg win,
	output reg tie,
	output reg lose,
	output [0:4]aces
);

// Defining Round Deal
reg deal;

// Defining Money Variables
wire  [15:0]bet = {12'd0, random_seed[3:0]};
reg   [15:0]total_money;

// Seven Segment Display Controls
reg  [7:0]display1; 
reg  [7:0]display2;

// Defining Player Card Value
reg  [31:0]value;
wire [31:0]val2;
wire [31:0]val3;
wire [31:0]val4;
wire [31:0]val5;

// Player Cards Initiated
wire [7:0]card1;
wire [7:0]card2;
wire [7:0]card3;
wire [7:0]card4;
wire [7:0]card5;

// Deal Player Cards
player PLAYER(clk, rst, deal, random_seed, new_random_seed, card1, card2, card3, card4, card5, val2, val3, val4, val5, aces);

// Defining Dealer Card Value
wire [31:0]dvalue1;
wire [31:0]dvalue;
wire [7:0]dcardsnum;

// Dealer Cards Initiated
wire [7:0]dcard1;
wire [7:0]dcard2;
wire [7:0]dcard3;
wire [7:0]dcard4;
wire [7:0]dcard5;

// Deal Dealer Logic
dealer DEALER(clk, rst, deal, {random_seed[2:0], random_seed[15:6], random_seed[2:0]}, new_random_seed, dcard1, dcard2, dcard3, dcard4, dcard5, dvalue1, dvalue, dcardsnum);


// Defining State and Next State
reg  [5:0]S;
reg  [5:0]NS;

// Defining Parameters
parameter   INITS = 6'b000000,
				START = 6'b000001,
				BET_WAIT = 6'b100010,
				BET = 6'b000010,
				C_2_WAIT = 6'b100011,
				C_2 = 6'b000011,
				C_3_WAIT = 6'b100100,
				C_3 = 6'b000100,
				C_4_WAIT = 6'b100101,
				C_4 = 6'b000101,
				C_5_WAIT = 6'b100110,				
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
				WIN = 6'b010001, 
				END = 6'b010010;

				
// Handle State Conditions
always@(*)
case(S)
	    INITS: NS = START;			 
	    START: if (!key4)
					NS = BET_WAIT;
				  else 
					NS = START;
	 BET_WAIT: if(key4)
					NS = BET;
				  else 
					NS = BET_WAIT;
			BET: if (!key4 & (bet > 16'd0))
					NS = C_2_WAIT;
				  else
				   NS = BET;
	 C_2_WAIT: if(key4)
					NS = C_2;
				  else 
					NS = C_2_WAIT; 
	      C_2: if (!key2) // key2 == hit
				   NS = C_3_WAIT;
				  else if (!key1) // key1 == stand
				   NS = DEAL;
				  else
				   NS = C_2;
	 C_3_WAIT: if(key2)
					NS = C_3;
				  else 
					NS = C_3_WAIT; 
	      C_3: if (value > 32'd21)
					NS = BUST;
				  else if (!key2)
					NS = C_4_WAIT;
				  else if (!key1)
					NS = DEAL;
				  else 
					NS = C_3;
	 C_4_WAIT: if(key2)
					NS = C_4;
				  else 
					NS = C_4_WAIT; 
	      C_4: if (value > 32'd21)
					NS = BUST;
				  else if (!key2)
					NS = C_5_WAIT;
				  else if (!key1)
					NS = DEAL;
				  else
					NS = C_4;
	 C_5_WAIT: if(key2)
					NS = C_5;
				  else 
					NS = C_5_WAIT; 
	      C_5: if (value > 32'd21)
					NS = BUST;
				  else
					NS = BJ_5;
	     BJ_5: if ((dvalue == 32'd21) & (dcardsnum == 32'd2))
					NS = DEAL_BJ;
				  else 
				   NS = WIN;
	     BUST: NS = LOST;
	     DEAL: if((dvalue == 32'd21) & (dcardsnum == 32'd2))
					NS = DEAL_BJ;
				  else if (dvalue > 32'd21)
				   NS = DEAL_BUST;
				  else if (value > dvalue)
					NS = DEAL_LOW;
				  else if (value == dvalue)
					NS = DEAL_TIE;
				  else 
					NS = DEAL_HIGH;
	  DEAL_BJ: if ((val2 == value) & (value == 32'd21))
					NS = TIE;
				  else
					NS = LOST;
	DEAL_BUST: NS = WIN;
	 DEAL_TIE: if (val2 == 32'd21)
					NS = WIN;
				  else
				   NS = TIE;
	DEAL_HIGH: NS = LOST;
	 DEAL_LOW: NS = WIN;
	     LOST: NS = END;
	      TIE: NS = END;
	      WIN: NS = END;
			END: if (!key4)
					NS = START;
				  else
					NS = END;
	  default: NS = INITS;
endcase


// Reset Condition and Next State Condition
always@(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		S <= INITS;
	else
	begin
		case(S)
			INITS: begin
						total_money <= 8'd200;
						deal <= 1'b0;
					 end
			START: begin 
						deal <= 1'b0;
						value <= 32'd0;
						total_money <= total_money;
					 end 
			C_2_WAIT: begin 
							deal <= 1'b1;
							total_money <= total_money;
						 end
			C_2: begin 
					deal <= 1'b0;
					value <= val2;
					total_money <= total_money;
				  end
			C_3: begin 
					deal <= 1'b0;
					value <= val3;
					total_money <= total_money;
				  end
			C_4: begin 
					deal <= 1'b0;
					value <= val4;
					total_money <= total_money;
				  end
			C_5: begin 
					deal <= 1'b0;
					value <= val5;
					total_money <= total_money;
				  end
			LOST: begin 
					total_money <= total_money + bet;
					deal <= 1'b0;
					end
			TIE: begin
				  total_money <= total_money;
				  deal <= 1'b0;
				  end
			WIN: begin
				  total_money <= total_money - bet;
				  deal <= 1'b0;
				  end
			default: begin 
						total_money <= total_money;
						deal <= deal;
						value <= value;
						end
		endcase 
		
		S <= NS;
	end
end


// Output Condition
always@(*)
case (S)
	START: begin 
			 win = win;
			 tie = tie;
			 lose = lose;
			 end
	C_2: begin 
			win = win;
			tie = tie;
			lose = lose;
		  end
	C_3: begin 
			win = win;
			tie = tie;
			lose = lose;
		  end
	C_4:  begin 
			win = win;
			tie = tie;
			lose = lose;
		  end
	C_5:  begin 
			win = win;
			tie = tie;
			lose = lose;
		  end
	WIN: begin
			win = 1'b1;
			tie = 1'b0;
			lose = 1'b0;
		  end
	TIE: begin
			win = 1'b0;
			tie = 1'b1;
			lose = 1'b0;
		  end
	LOST: begin
			win = 1'b0;
			tie = 1'b0;
			lose = 1'b1;
			end
	END: begin 
			win = win;
			tie = tie;
			lose = lose;
		  end
	default: begin 
				win = 1'b0;
				tie = 1'b0;
				lose = 1'b0;
				end
endcase


// Display Controls
always@(*)
begin
	if (!key3)
	begin
		if (((S > 6'b001001) & (S < 6'b100000)))
		begin
			display1 = value[7:0];
			display2 = dvalue[7:0];
		end
		else if ((S == 6'b000010) | (S == 6'b000001))
		begin
			display1 = 8'd0;
			display2 = 8'd0;
		end
		else
		begin
			display2 = dvalue1[7:0];
			display1 = value[7:0];
		end
	end
	else
	begin
		display1 = bet[7:0];
		display2 = {2'b00, S};
	end


end


// Display Modules
four_decimal_vals MONEY(total_money, seg7_dig1, seg7_dig2, seg7_dig3, seg7_dig4);
two_decimal_vals BETS(display1, seg7_dig5, seg7_dig6);
two_decimal_vals STATE(display2, seg7_dig7, seg7_dig8);

endmodule
