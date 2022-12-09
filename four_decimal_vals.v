module four_decimal_vals (
input [15:0]val,
output [6:0]seg7_dig0,
output [6:0]seg7_dig1,
output [6:0]seg7_dig2,
output [6:0]seg7_dig3
);

integer storage;

integer dig0;
integer dig1;
integer dig2;
integer dig3;

reg [3:0] result_dig0;
reg [3:0] result_dig1;
reg [3:0] result_dig2;
reg [3:0] result_dig3;

// Create the module to display the 8 bit result
always@(*)
begin 
	storage = (val[0] * 1) + (val[1] * 2) + (val[2] * 4) + (val[3] * 8) + (val[4] * 16) + (val[5] * 32) + (val[6] * 64) + (val[7] * 128) + (val[8] * 256) + (val[9] * 512) + (val[10] * 1024);

	dig0 = storage % 10;
	dig1 = ((storage - (storage %   10)) /   10) % 10;
	dig2 = ((storage - (storage %  100)) /  100) % 10;
	dig3 = ((storage - (storage % 1000)) / 1000) % 10;

	
	result_dig0 = dig0[3:0];
	result_dig1 = dig1[3:0];
	result_dig2 = dig2[3:0];
	result_dig3 = dig3[3:0];
end

// Displays
seven_segment ONES(result_dig0, seg7_dig0);
seven_segment TENS(result_dig1, seg7_dig1);
seven_segment HUNDREDS(result_dig2, seg7_dig2);
seven_segment THOUSANDS(result_dig3, seg7_dig3);



endmodule