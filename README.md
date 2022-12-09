# ECE287_Blackjack
This project implements verilog code in order to output a playable single-person game of blackjack
to the Altera DE2-115 FPGA board.

# Project Description
Our project is an iteration of blackjack on the DE2-115 board in a way similar to
that of the Atari 2600 blackjack game. This project was able to be designed through 
the use of verilog code to create a FSM that outputs to an FPGA (Altera DE2-115). The game consists of a single play option: player vs computer,
where the computer plays as the dealer. Through the use of a Linear Feedback Shift Register (LFSM), 
the player and dealer are assigned cards at random, ranging from 2-10, Jack, Queen, King, and Ace. All face 
cards hold their typical values and the value of the Ace will be determined based on projected outcome, meaning
the value will be assigned 1 if the projected result is a bust, and 11 otherwise. 
Players are assigned 200 credits at the start of the game, and are able to place a bet that ranges from 1-15
each turn. Upon initialization of the game, a first state will be entered. Following the first state, the player is then
able to move into the second state (betting phase) where the player is able to bet a desired amount of credits.
This state cannot be left until a bet of 1 or larger is placed. Once a bet is placed, the player then moves into 
the next state through the use of ??? BUTTON 4???. In the third state, the player is delt 2 cards and the value of 
that is shown on the board's seven segment display. While in this state the player is able to see their values
as well as the value of the single card displayed by the dealer, where they are then able to either hit or stand.
The player will be able to hit all the way up until they bust, at which point the number of credits placed as the
bet will be deducted from the standing count. If the player chooses to stand at a value less than or equal to 21, the 
computer will then resume play and the value of the second card will be added. If the value of the second card brings the 
total to that of 16 or lower, the computer will hit until a value of 17 or greater is reached. Upon reaching a value of 17 or greater, 
the computer will stand and the values of both dealer and player will be compared. If the player has a higher value they will be awared 
the win and receive credits equal to that of their bet. In the case of a push all credits will be returned, and 
in the case of a loss the total bet will be deducted from the standing balance. Following the result, the second state 
(betting phase) will be entered, and the aforementioned process will continue to run until a either a balance of 0
or 1000 is reached, in both cases the game will terminate. 


