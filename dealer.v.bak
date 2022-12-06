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

wire [7:0]random1;
wire [7:0]random2;
wire [7:0]random3;

wire [7:0]value_2cards1;
wire [7:0]value_3cards1;
wire [7:0]value_4cards1;
wire [7:0]value_5cards1;

wire [7:0]value_2cards2;
wire [7:0]value_3cards2;
wire [7:0]value_4cards2;
wire [7:0]value_5cards2;

reg [7:0]vc2;
reg [7:0]vc3;
reg [7:0]vc4;
reg [7:0]vc5;

random_generator_3 DEALRANDOM(seed, random1, random2, random3);

draw DCARD3(random1, card3, suit3);
draw DCARD4(random2, card4, suit4);
draw DCARD5(random3, card5, suit5);

hand VALUE2(card1, card2, value_2cards1, value_2cards2);
hit VALUE3(value_2cards1, value_2cards2, card3, value_3cards1, value_3cards2);
hit VALUE4(value_3cards1, value_3cards2, card4, value_4cards1, value_4cards2);
hit VALUE5(value_4cards1, value_4cards2, card4, value_5cards1, value_5cards2);


/*
This module takes care of dealer logic
*/
always@(*)
begin 



end




endmodule
