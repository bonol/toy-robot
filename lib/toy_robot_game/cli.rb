require 'readline'
require_relative '../toy_robot_game'

module ToyRobotGame
  class CLI
    include InfoPresenter

    def initialize(col, row)
      @col ||= 6
      @row ||= 6
      board = GameBoard.new(@col, @row)
      @simulator = GameSimulator.new(board)
    end

    def start
      present_init
      present_helper
      while buf = Readline.readline('> ', true)
        begin
          command = ToyRobotGame::Command.process(buf)
          run [command]
        rescue ToyRobotGame::RobotError => e
          puts "command error: #{e.message}"
          next
        rescue => e
          puts 'rescue from error, please try again.'
          puts "error message: #{e.message}"
          next
        end
      end
    end

    def run(commands)
      commands.each do |command, *args|
        @simulator.send(command, *args)
      end
    end
  end
end
