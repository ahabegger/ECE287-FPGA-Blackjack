module Blackjack(
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

/* Instantiate Starter Money */
wire [7:0]total_money = 8'd200;
reg [7:0]bet = 8'd0;

/* Displays Total Money */
three_decimal_vals_w_neg TOTAL(total_money, seg7_neg_sign, seg7_dig0, seg7_dig1, seg7_dig2);

/* Displays Bet */
two_decimal_vals BET(bet, seg7_dig3, seg7_dig4);

always@(*)
begin

	/* Increment Bet Amounts */
	if (increment_1)
		bet = bet + 8'd1;
	if (increment_5)
		bet = bet + 8'd5;
	if (increment_10)
		bet = bet + 8'd10;
	if (increment_25)
		bet = bet + 8'd25;
		
	/* Creates 99 Bet Ceiling */
	if (bet > 8'd99)
		bet = 8'd99;
		
end
endmodule