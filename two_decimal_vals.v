module two_decimal_vals(
input [7:0]val,
output [6:0]seg7_dig0,
output [6:0]seg7_dig1
);

integer storage;
integer dig0;
integer dig1;

reg [3:0] result_dig0;
reg [3:0] result_dig1;

/* create the module to display the 8 bit result */
always@(*)
begin 
	storage = (val[0] * 1) + (val[1] * 2) + (val[2] * 4) + (val[3] * 8) + (val[4] * 16) + (val[5] * 32) + (val[6] * 64) + (val[7] * 128);

	dig0 = storage % 10;
	dig1 = ((storage - (storage %  10)) /  10) % 10;
	
	result_dig0 = dig0;
	result_dig1 = dig1;
	
end

// Displays
seven_segment ZERO(result_dig0, seg7_dig0);
seven_segment ONE(result_dig1, seg7_dig1);

endmodule