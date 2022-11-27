module three_decimal_vals_w_neg (
input [7:0]val,
output [6:0]seg7_neg_sign,
output [6:0]seg7_dig0,
output [6:0]seg7_dig1,
output [6:0]seg7_dig2
);

integer storage;
reg is_neg;

integer dig0;
integer dig1;
integer dig2;

reg [3:0] result_dig0;
reg [3:0] result_dig1;
reg [3:0] result_dig2;

/* create the module to display the 8 bit result */
always@(*)
begin 
	if(val[7])
	begin
		is_neg = 1'b1;
		storage = ((!val[0]) * 1) + ((!val[1]) * 2) + ((!val[2]) * 4) + ((!val[3]) * 8) + ((!val[4]) * 16) + ((!val[5]) * 32) + ((!val[6]) * 64) + 1;
	end
	else
	begin
		is_neg = 1'b0;
		storage = (val[0] * 1) + (val[1] * 2) + (val[2] * 4) + (val[3] * 8) + (val[4] * 16) + (val[5] * 32) + (val[6] * 64);
	end

	dig0 = storage % 10;
	dig1 = ((storage - (storage %  10)) /  10) % 10;
	dig2 = ((storage - (storage % 100)) / 100) % 10;
	
	result_dig0 = dig0;
	result_dig1 = dig1;
	result_dig2 = dig2;
	
end

// Displays
seven_segment_negative NEG(is_neg, seg7_neg_sign);
seven_segment ZERO(result_dig0, seg7_dig0);
seven_segment ONE(result_dig1, seg7_dig1);
seven_segment TWO(result_dig2, seg7_dig2);


endmodule