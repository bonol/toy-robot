Toy Robot Game
==============

Simulate a toy robot moving on a square board of N x M units. Player can place multiple robots to the board.

The robot can roam around the surface of the board but shouldn't
be able to fall off the edge or collide with other robots.

## Getting Started

### Play game with default 6 * 6 board
#### Run:
ruby exe/toy_robot.rb

### Play game with N x M size board
#### Run:
ruby exe/toy_robot.rb 5 5

### Start the game:
START  
PLACE robot_name X,Y,Direction

## Test

#### Run: rspec

## Commands available (all commands are not case sensitive)
> HELP
>- list all commands available

> EXIT
>- exit game CLI

> START
>- clear all robots and create a clean board for game

> LIST ROBOTS
>- list robots on the board with their current positions

> PLACE
>- put a toy robot on the board, robot position X,Y and facing
>- example: PLACE robotname 2,2,NORTH

> LEFT
>- rotate a robot 90 degrees to the left
>- example: LEFT robotname or LEFT

> RIGHT
>- rotate a robot 90 degrees to the right
>- example: RIGHT robotname or RIGHT

> REPORT
>- report a robot current position and facing direction
>- example: REPORT robotname or REPORT

> MOVE
>- move a robot one step/unit forward
>- example: MOVE robotname or MOVE

## Example Input and Output
### (a) 
    START
    PLACE tony 0,0,NORTH  
    MOVE  
    REPORT  
    Output: tony: 0,1,NORTH
### (b)
    START
    PLACE tony 0,0,NORTH  
    LEFT  
    REPORT  
    Output: tony: 0,0,WEST
### (c)
    START
    PLACE tony 1,2,EAST  
    MOVE  
    MOVE  
    LEFT  
    MOVE  
    REPORT  
    Output: tony: 3,3,NORTH
### (d)
    START
    PLACE tony 0,0,NORTH  
    MOVE  
    REPORT  
    Output: tony: 0,1,NORTH
    PLACE thor 0,1,EAST
    Output: PLACE robot failed - position already taken
    PLACE thor 3,3,NORTH
    RIGHT tony
    LEFT thor
    LIST ROBOTS
    Output: tony: 0,1,EAST
            thor: 3,3,WEST
