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

HELP              -- list all commands available

EXIT              -- exit game CLI

START             -- clear all robots and create a clean board for game

LIST ROBOT        -- list robots on the board with their current positions

PLACE             -- put a toy robot on the board, robot position X,Y and facing
                  -- example: robotname: PLACE 2,2,NORTH

LEFT              -- rotate a robot 90 degrees to the left
                  -- example: robotname: LEFT

RIGHT             -- rotate a robot 90 degrees to the right
                  -- example: robotname: RIGHT

REPORT            -- report a robot current position and facing direction
                  -- example: robotname: REPORT

MOVE              -- move a robot one step/unit forward
                  -- example: robotname: MOVE
