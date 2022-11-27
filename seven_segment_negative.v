module seven_segment_negative(i,o);

input i;
output reg [6:0]o; 


//   abcdefg
//
//      ---  g
//    b|   | f
//      ---  a
//    c|   | e
//      ---  d


always@(*)
begin
	case (i)
		1'b1: o = 7'b0111111; 
		default: o = 7'b1111111;
	endcase
end

endmodule