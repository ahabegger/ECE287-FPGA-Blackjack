# ECE287_Blackjack

This is the ECE287 Final Project

Our proposed project is to recreate blackjack on the DE2-115 board in a way similar to
that of the Atari 2600 blackjack game. This will be done through Verilog code, with the display
on the board outputting the given cards, and eventually the result of who wins. This game will
have one play type: the player versus a computer, where the computer acts as the dealer. This
game will mimic real blackjack, with the typical constraints on the dealer as to when to hold/hit,
and all of the standard options such as  hold and hit will be available to the
player. These choices will be able to be made through separate pin assignments and will
appear on the DE2-115 display. The cards available for play will be randomized out of a pool of 52 
possibilities that will be selected through the use of a Linear Feedback Shift Register (LFSM). F
inally, players will start with 200 credits and can wager a specific amount, ranging from 1-15 credits, 
against the dealer through pin assignment. The game will continue to play until
the player either “breaks the bank” by reaching 1000 credits or reaches 0 credits, in both cases
the game will self terminate.
