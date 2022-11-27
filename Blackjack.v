module Blackjack(
	output [6:0]seg7_neg_sign,
	output [6:0]seg7_dig0,
	output [6:0]seg7_dig1,
	output [6:0]seg7_dig2
);


reg [7:0]sum;


/* Seven Segment Display */
/* instantiate the module to display the 8 bit result */
three_decimal_vals_w_neg bets(sum, seg7_neg_sign, seg7_dig0, seg7_dig1, seg7_dig2);


endmodule