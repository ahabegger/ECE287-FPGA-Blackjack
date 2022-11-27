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

wire [7:0]dcard1;
wire [7:0]dcard2;
wire [7:0]dcard3;
wire [7:0]dcard4;
wire [7:0]dcard5;

wire [7:0]pcard1;
wire [7:0]pcard2;
wire [7:0]pcard3;
wire [7:0]pcard4;
wire [7:0]pcard5;

// random_generator_4 RAND(seed, random1, random2, random3, random4);


// DEALER
draw DCARD1(random1, dcard1, suit1);
draw DCARD2(random2, dcard2, suit2);

// PLAYER
draw PCARD1(random3, pcard1, suit3);
draw PCARD2(random4, pcard2, suit4);

// Calculate Hands
dealer DEALER(seed, dcard1, dcard2, dcard3, dcard4, dcard5);

// Display Modules



endmodule
