module seven_segment (in, o);
input [3:0] in;
output reg [6:0] o;

//   abcdefg
//
//      ---  g
//    b|   | f
//      ---  a
//    c|   | e
//      ---  d


always@(*)
begin
	case (in)
		4'b0000: o = 7'b1000000;//0
		4'b0001: o = 7'b1111001;//1
		4'b0010: o = 7'b0100100;//2
		4'b0011: o = 7'b0110000;//3

		4'b0100: o = 7'b0011001;//4
		4'b0101: o = 7'b0010010;//5
		4'b0110: o = 7'b0000010;//6
		4'b0111: o = 7'b1111000;//7

		4'b1000: o = 7'b0000000;//8
		4'b1001: o = 7'b0010000;//9

		default: o = 7'b0000000;
	endcase
end
endmodule