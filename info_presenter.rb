#CLI presentation helper

module InfoPresenter
  def present_helper
    puts '---------------------------------------------------------------------------'
    puts 'start             -- clear all robots and create a clean board for game'
    puts 'add               -- add robot to the board'
    puts 'use               -- use an existing robot by robot name'
    puts 'list robots       -- list robots on the board with their current positions'
    puts 'place             -- put a toy robot on the board'
    puts 'left              -- rotate a robot 90 degrees to the left'
    puts 'right             -- rotate a robot 90 degrees to the right'
    puts 'move              -- move a robot one step/unit forward'
    puts 'exit              -- exit CLI'
    puts '---------------------------------------------------------------------------'
  end

  def present_init
    puts 'Welcome to Robot Toy!'
    puts 'Start a new game with the start command!'
    puts 'type help to list all commands available.'
  end
end