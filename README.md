# ECE287_Blackjack
###

This project implements verilog code to output a playable single-person game of blackjack
to the Altera DE2-115 FPGA board.

## Background

Blackjack is a popular card game that can be played with multiple people and one dealer. The game starts with every player, including the dealer, being dealt two cards. The players are dealt their cards face up while the dealer lays both face down and flips one over. From there, players take their total value and decide to hit either (obtain another card), and can continue to hit until they reach a value they like where they can stand, or reach a value over 21 (bust), or stand at their initial value. Once the player stands, the turn switches to the dealer. During the next stage, the dealer will flip the second card over, and if the value of the two cards combined is 17 or over, the dealer will stand, and the values of the dealer and player will be compared. If the dealer's card value is less than the player's, the player wins and is rewarded 100% based on the original bet. If the dealer has a higher combined value, the player simply loses all of their placed bet. If the player and dealer have the same values, a push will be called, and the player will receive the placed bet back. Finally, if the player receives a natural blackjack (combined value of 21 from only the first two cards), they are awarded a payment value of 3:2 based on their placed bet.

## Project Description

Our project is an iteration of blackjack on the DE2-115 board in a way similar to
that of the Atari 2600 blackjack game. This project used Verilog code to create an FSM that outputs to an FPGA (Altera DE2-115). The game consists of a single-play option: player vs computer,
where the computer plays as the dealer. Using a Linear Feedback Shift Register (LFSR), 
the player and dealer are randomly assigned cards ranging from 2-10, Jack, Queen, King, and Ace. All face 
cards hold their typical values, and the value of the Ace will be determined based on the projected outcome, meaning
the value will be assigned one if the projected result is a bust and 11 otherwise. 
Players are assigned 200 credits at the start of the game and can place a bet that ranges from 1 to 15
each turn. Upon initialization of the game, a first state will be entered. Following the first state, the player can then move into the second state (betting phase), where the player can bet a desired amount of credits.
This state cannot be left until a bet of 1 or larger is placed. Once a bet is placed, the player moves into
the next state using Button 3. In the third state, the player is dealt two cards, and the value of 
that is shown on the board's seven-segment display. In this state, the player can see their values
and the value of the single card displayed by the dealer, where they can either hit or stand.
The player can hit up until they bust, at which point the number of credits placed as the
bet will be deducted from the standing count. If the player chooses to stand at a value less than or equal to 21, the 
computer will then resume play, and the value of the second card will be added. If the value of the second card brings the 
total to 16 or lower, the computer will hit until a value of 17 or greater is reached. Upon reaching a value of 17 or greater, 
the computer will stand, and the dealer and player's values will be compared. If the player has a higher value, they will be awarded 
the win and receive credits equal to their bets. In the case of a push, all credits will be returned, and 
in the case of a loss, the total bet will be deducted from the standing balance. Following the result, the second state 
(betting phase) will be entered, and the aforementioned process will continue to run until either a balance of 0
or 1000 is reached, in both cases, the game will terminate. 

## Statechart 

<img width="500" alt="" src="https://github.com/ahabegger/ECE287-FPGA-Blackjack/blob/main/State_Diagram.jpg?raw=true">

## Design

Below are the modules used to make this design possible, with a short description.

### Blackjack.v

This module acts as the top-level module and facilitates the program's function. This module can do so by controlling the states and determining each result through if statements and other conditionals. As this module controls most of what occurs, it is also responsible for modifying credit balance and sending the outputs of card and credit values to the seven-segment display on FPGA by calling the seven-segment.v module. Below is an example of how Blackjack.v functions.
<img width="534" alt="Screen Shot 2022-12-09 at 5 59 24 PM" src="https://user-images.githubusercontent.com/119711095/206809127-2f1e8114-3322-4b56-b5a9-282893b37e64.png">

### Random.v

Random.v is the module used to determine the value of the cards drawn by the player and dealer. This module can generate the random values by using an LFSR that oscillates through the values of 0-51 with every tick and pulls the value(s) held at the instance where it is called. Random.v takes the value from the LFSR, stores it, and determines it. Below are both the LFSR and formulas used to determine the aforementioned values. 

<img width="693" alt="Screen Shot 2022-12-09 at 6 01 01 PM" src="https://user-images.githubusercontent.com/119711095/206809220-b3a65fd3-22d8-480b-add8-d3cd30d4c474.png">

<img width="542" alt="Screen Shot 2022-12-09 at 6 02 11 PM" src="https://user-images.githubusercontent.com/119711095/206809431-a602f68a-65c0-44fc-907e-612835bfe1df.png">

### Dealer.v

Dealer.v is the module responsible for storing the dealer card values and determining if the requirements for blackjack have been met.

## Player.v
Like Dealer.v, Player.v is responsible for storing the values of the drawn cards and then determining if they meet the requirements for blackjack each time around.

## Result

Using a finite state machine, we created a fully functioning blackjack version accessible through the Altera DE2-115 board. This program incorporated multiple forms of state handling, a linear feedback shift register, and multiple methods to form a complex function that achieved the end goal of a functioning game.

## Product Images 

<img width="500" alt="Screen Shot 2022-12-09 at 6 14 41 PM" src="https://user-images.githubusercontent.com/119711095/206810444-4e97a0bd-3552-4c84-9ce1-872ccdac88b9.png">

## Disclaimer
This project is part of an academic exercise and is not intended for commercial use.
