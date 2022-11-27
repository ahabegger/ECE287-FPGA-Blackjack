module round(
input round_start,
input [7:0]seed
);

wire [7:0]random1;
wire [7:0]random2;
wire [7:0]random3;
wire [7:0]random4;

wire [1:0]suit1;
wire [1:0]suit2;
wire [1:0]suit3;
wire [1:0]suit4;

wire [7:0]card1;
wire [7:0]card2;
wire [7:0]card3;
wire [7:0]card4;

// random_generator_4 RAND(seed, random1, random2, random3, random5);


// DEALER
draw DCARD1(random1, card1, suit1);
draw DCARD2(random2, card2, suit2);

// PLAYER
draw PCARD1(random3, card3, suit3);
draw PCARD2(random4, card4, suit4);

// Calculate Hands


// Display Modules



endmodule
