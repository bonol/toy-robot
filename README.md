Toy Robot Game
==============

Simulate a toy robot moving on a square board of 6 x 6 units. The robot can roam around the surface of the board but shouldn't
be able to fall off the edge or collide with other robots.

## Getting Started

run
ruby cli.rb

### Test

run rspec for test

### Commands available

help              -- list all commands available

exit              -- exit game CLI

start             -- clear all robots and create a clean board for game

add               -- add robot to the board, example: add ROBOT_NAME

use               -- use an existing robot by robot name, example: use ROBOT_NAME

list robots       -- list robots on the board with their current positions

place             -- put a toy robot on the board, robot position X,Y and facing, example place 2 2 north

left              -- rotate a robot 90 degrees to the left without changing the position of the robot

right             -- rotate a robot 90 degrees to the right without changing the position of the robot

report            -- report a robot current position and facing direction

move              -- move a robot one step/unit forward, example: move
