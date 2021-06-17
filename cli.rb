require 'readline'
require './toy_robot_game'

module ToyRobotGame
  class CLI
    extend InfoPresenter

    def self.start
        present_init
        board = GameBoard.new(6,6)
        while buf = Readline.readline('> ', true)
          begin
            case buf
            when /START/i
              board.start_game
              puts 'start new game'
            when /LIST\sROBOTS/i
              board.display_robots
            when /([a-z])+:\sPLACE\s/i
              if board.is_game_on?
                res = board.place_robot_on_board(buf)
                puts res ? "PLACE robot succeeded" : "PLACE robot failed"
              else
                puts 'Please start a new game'
              end
            when /([a-z])+:\sLEFT/i
              if board.is_game_on?
                 res = board.turn_robot_on_board(buf, 'left')
                  puts res ? "#{robot_name(buf)} turned LEFT" : "#{robot_name(buf)} failed to turn"
              else
                puts 'Please start a new game'
              end
            when /([a-z])+:\sRIGHT/i
              if board.is_game_on?
                res = board.turn_robot_on_board(buf, 'right')
                puts res ? "#{robot_name(buf)} turned RIGHT" : "#{robot_name(buf)} failed to turn"
              else
                puts 'Please start a new game'
              end
            when /([a-z])+:\sREPORT/i
              if board.is_game_on?
                if board.robot_exist?(robot_name(buf))
                  board.set_current_robot(robot_name(buf))
                  board.current_robot.report
                else
                  puts 'Please use an existing robot'
                end
              else
                puts 'Please start a new game'
              end
            when /([a-z])+:\sMOVE/i
              if board.is_game_on?
                res = board.move_robot_on_board(buf)
                puts res ? "#{robot_name(buf)} MOVE 1 unit" : "#{robot_name(buf)} failed to MOVE"
              else
                puts 'Please start a new game'
              end
            when /HELP/i
              present_helper
            when /EXIT/i
              puts 'Bye for now.'
              exit
            else
              puts 'Can not recognize your command, please try again!'
            end
          rescue => e
            puts 'rescue from error, please try again.'
            puts "error message: #{e.message}"
            next
          end
        end
    end

    def self.robot_name(str)
      str.split(' ').first.delete_suffix(':')
    end
  end
end

ToyRobotGame::CLI.start