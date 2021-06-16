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
            when 'start'
              board.start_game
              puts 'start new game'
            when 'restart'
              board.restart_game
              puts 'restart new game'
            when /add\s/
              if board.is_game_on? && board.within_robot_limit?
                board.add_robot(robot_name(buf))
                puts "Add new robot #{robot_name(buf)}"
              else
                puts 'Please start a new game'
              end
            when /use\s/
              if board.is_game_on?
                unless board.robot_exist?(robot_name(buf))
                  puts "#{robot_name(buf)} does not exist"
                  next
                end
                board.set_current_robot(robot_name(buf))
                puts "current active robot is #{robot_name(buf)}"
              else
                puts 'Please start a new game'
              end
            when 'list robots'
              board.display_robots
            when /place\s/
              if board.is_game_on? && board.current_robot
                unless board.valid_place_attrs?(buf)
                  puts 'PLACE robot failed - invalid attributes'
                  next
                end
                attrs = buf.split(' ').last.split(',')
                res = board.place_robot(attrs[0],attrs[1],attrs[2])
                puts res ? "PLACE robot succeeded" : "PLACE robot failed - collided with existing robot"
              else
                puts 'Please use a robot to play'
              end
            when 'left'
              if board.is_game_on? && board.current_robot && board.current_robot.is_active?
                board.current_robot.turn('left')
              else
                puts 'Please use a robot to play or place the robot to board'
              end
            when 'right'
              if board.is_game_on? && board.current_robot && board.current_robot.is_active?
                board.current_robot.turn('right')
              else
                puts 'Please use a robot to play or place the robot to board'
              end
            when 'report'
              if board.is_game_on? && board.current_robot
                board.current_robot.report
              else
                puts 'Please use a robot to play'
              end
            when 'move'
              if board.is_game_on? && board.current_robot && board.current_robot.is_active?
                if board.new_position_collided?('move', {move: 1})
                  puts 'Can not move the robot'
                else
                  board.current_robot.move
                end
              else
                puts 'Please use a robot to play or place the robot to board'
              end
            when 'help'
              puts 'present_helper'
            when 'exit'
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
      str.split(' ').last
    end
  end
end

ToyRobotGame::CLI.start