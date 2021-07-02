require_relative '../toy_robot_game'
require_relative './game_simulator_helper'

module ToyRobotGame
  class GameSimulator
    include GameSimulatorHelper

    attr_accessor :board, :existing_robots, :game_state, :current_robot
    def initialize(board)
      @board = board
      @existing_robots = []
      @game_state = 'standby'
      @current_robot = nil
    end

    def invalid(command)
      puts "'#{command.strip}' is an invalid command"
    end

    def start_game
      @game_state = 'playing'
      @existing_robots = []
      @current_robot = nil
    end

    def display_robots
      if @existing_robots.count > 0
        @existing_robots.each do |robot|
          puts "#{robot.name}: #{robot.x},#{robot.y},#{robot.direction.upcase}"
        end
      else
        puts "No robot on the board"
      end
    end

    def place(robot_name, x, y, direction)
      if is_game_on?
        unless valid_place_attrs?(x, y, direction)
          puts 'PLACE robot failed - invalid attributes'
          return
        end

        if new_position_collided?('place', {x: x,y: y})
          puts 'PLACE robot failed - position already taken'
          return
        end

        if robot_exist?(robot_name)
          puts 'Robot already on board'
          return
        else
          if within_robot_limit?
            add_robot(robot_name)
            set_current_robot(robot_name)
          else
            puts 'Reach Robot limit!'
            return
          end
        end
        @current_robot.place(x, y ,direction)
        puts "PLACE robot succeeded"
      else
        puts 'Please start a new game'
      end
    end

    def turn_left(robot_name)
      if is_game_on?
        turn_robot_on_board(robot_name, 'left')
      else
        puts 'Please start a new game'
      end
    end

    def turn_right(robot_name)
      if is_game_on?
        turn_robot_on_board(robot_name, 'right')
      else
        puts 'Please start a new game'
      end
    end

    def report(robot_name)
      if is_game_on?
        if robot_exist?(robot_name)
          set_current_robot(robot_name)
          @current_robot.report
        else
          puts 'Please use an existing robot'
        end
      else
        puts 'Please start a new game'
      end
    end

    def move(robot_name)
      if robot_exist?(robot_name)
        set_current_robot(robot_name)
        @current_robot.move unless new_position_collided?('move', {move: 1})
        true
        new_position_collided?('move', {move: 1}) ? false : @current_robot.move
      else
        puts 'Please use an existing robot and place it to board'
      end
    end
  end
end