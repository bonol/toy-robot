#CLI presentation helper
module ToyRobotGame
  module InfoPresenter
    def present_helper
      puts '---------------------------------------------------------------------------'
      puts 'START             -- clear all robots and create a clean board for game'
      puts 'LIST ROBOTS       -- list robots on the board with their current positions'
      puts 'PLACE             -- put a toy robot on the board, robotname: PLACE 1,2,NORTH'
      puts 'LEFT              -- rotate a robot 90 degrees to the left, robotname: LEFT'
      puts 'RIGHT             -- rotate a robot 90 degrees to the right, robotname: RIGHT'
      puts 'MOVE              -- move a robot one step/unit forward, robotname: MOVE'
      puts 'REPORT            -- report robot current position, robotname: REPORT'
      puts 'EXIT              -- exit CLI'
      puts '---------------------------------------------------------------------------'
    end

    def present_init
      puts 'Welcome to Robot Toy!'
      puts 'Start a new game with the start command!'
    end
  end
end