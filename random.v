module random(
input clk,
input rst,
input deal,
input [15:0]random_seed,
input new_random_seed,
output reg [7:0]card1, 
output reg [7:0]card2, 
output reg [7:0]card3, 
output reg [7:0]card4, 
output reg [7:0]card5
);

// Card Holder
reg [7:0]card1_holder;
reg [7:0]card2_holder;
reg [7:0]card3_holder;
reg [7:0]card4_holder;
reg [7:0]card5_holder;

// Random Variables
reg [127:0]lfsr; // this is a linear feedback shift register
reg [15:0]random_number;

/*
Card Logic 
8'd0 == 8'b00000000
8'd51 == 8'b00110011 
*/

wire [7:0]max_card = 8'b00110100; 

always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		random_number <= 16'd0;
		lfsr <= 128'd42;
	end
	else
	begin
		if (new_random_seed == 1'b1)
		begin
			/* initialize every 8 bits with the random seed */
			lfsr <= {
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed};
						
		end
		else
		begin
			/* when to output a value */
			if (deal == 1'b1)
				random_number = lfsr[63:48]; // picked an arbitrary sequence from the lfsr
			else
				/* constantly be shifting the lfsr */
				lfsr <= {lfsr[126:96], lfsr[0] ^ lfsr[62] ^ lfsr [120] ^ lfsr[2],  // 32 bits
						 lfsr[94:64], lfsr[5] ^ lfsr[81] ^ lfsr [97] ^ lfsr[94], // 32 bits
						 lfsr[62:32], lfsr[3] ^ lfsr[30] ^ lfsr [111] ^ lfsr[93],  // 32 bits
						 lfsr[30:0], lfsr[7] ^ lfsr[127] ^ lfsr [112] ^ lfsr[92]}; // 32 bits
		end
	end
end



always@(*)
begin 
   //reg [15:0]random_number;

	/*
	Card Logic 
	8'd0 == 8'b00000000
	8'd51 == 8'b00110011 
	*/

	//wire [7:0]max_card = 8'b00110100; 
	
	card1_holder = {2'b00, random_number[5:0]};
	card2_holder = {2'b00, random_number[10:5]};
	card3_holder = {2'b00, random_number[15:5]};
	card4_holder = {2'b00, random_number[2:0], random_number[15:13]};
	card5_holder = {2'b00, random_number[6:3], random_number[10:9]};

	// Max Card Logic
	if (card1_holder >= max_card)
		card1 = {3'b000, card1_holder[4:0]};
	else 
		card1 = card1_holder;
		
	if (card2_holder >= max_card)
		card2 = {3'b000, card2_holder[4:0]};
	else 
		card2 = card2_holder;
		
	if (card3_holder >= max_card)	
		card3 = {3'b000, card3_holder[4:0]};
	else 
		card3 = card3_holder;
		
	if (card4_holder >= max_card)	
		card4 = {3'b000, card4_holder[4:0]};
	else 
		card4 = card4_holder;
		
	if (card5_holder >= max_card)
		card5	= {3'b000, card5_holder[4:0]};
	else 
		card5 = card5_holder;

end


/*
module random_number_generator(
	input clk,
	input rst,
	input [15:0]random_seed,
	input new_random_seed,
	input random_number_output,
	output reg [15:0]random_number
);

//=======================================================
//  PORT declarations
//=======================================================
reg [127:0]lfsr; // this is a linear feedback shift register

//=======================================================
//  Design
//=======================================================

always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		random_number <= 16'd0;
		lfsr <= 128'd42;
	end
	else
	begin
		if (new_random_seed == 1'b1)
		begin
			//initialize every 8 bits with the random seed
			lfsr <= {
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed,
						random_seed};
						
		end
		else
		begin
			// when to output a value 
			if (random_number_output == 1'b1)
				random_number = lfsr[63:48]; // picked an arbitrary sequence from the lfsr
			else
				// constantly be shifting the lfsr 
				lfsr <= {lfsr[126:96], lfsr[0] ^ lfsr[62] ^ lfsr [120] ^ lfsr[2],  // 32 bits
						 lfsr[94:64], lfsr[5] ^ lfsr[81] ^ lfsr [97] ^ lfsr[94], // 32 bits
						 lfsr[62:32], lfsr[3] ^ lfsr[30] ^ lfsr [111] ^ lfsr[93],  // 32 bits
						 lfsr[30:0], lfsr[7] ^ lfsr[127] ^ lfsr [112] ^ lfsr[92]}; // 32 bits
		end
	end
end

endmodule
*/


endmodule 
