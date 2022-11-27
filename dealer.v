module dealer(
input [7:0]seed,
input [7:0]card1,
input [7:0]card2,
output [7:0]card3,
output [7:0]card4,
output [7:0]card5,
output [1:0]suit3,
output [1:0]suit4,
output [1:0]suit5,
output reg [7:0]value,
output bust
);

wire random1;
wire random2;
wire random3;

wire value_2cards1;
wire value_3cards1;
wire value_4cards1;
wire value_5cards1;

wire value_2cards2;
wire value_3cards2;
wire value_4cards2;
wire value_5cards2;

random_generator_3 DEALRANDOM(seed, random1, random2, random3);

draw DCARD3(random1, card3, suit3);
draw DCARD4(random2, card4, suit4);
draw DCARD5(random3, card5, suit5);

/*
hand VALUE2();
hand VALUE3();
hand VALUE4();
hand VALUE5();
*/


/*
This module takes care of dealer logic
*/






endmodule
