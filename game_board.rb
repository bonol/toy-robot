require './toy_robot_game'
require_relative './game_board_helper'

module ToyRobotGame
  class GameBoard
    include GameBoardHelper
    attr_accessor :col_num, :row_num, :existing_robots, :game_state, :current_robot

    def initialize(x,y)
      @col_num = x
      @row_num = y
      @existing_robots = []
      @game_state = 'standby'
      @current_robot = nil
    end

    # methods to configure game
    def start_game
      @game_state = 'playing'
      @existing_robots = []
      @current_robot = nil
    end

    def add_robot(name)
      new_robot = Robot.new(name)
      @existing_robots << new_robot
    end

    def set_current_robot(robot_name)
      @current_robot = get_robot_by_name robot_name
    end

    # methods to play game
    def place_robot_on_board(str)
      unless valid_place_attrs?(str)
        puts 'PLACE robot failed - invalid attributes'
        return false
      end
      if robot_exist?(robot_name(str))
        set_current_robot(robot_name(str))
      else
        if within_robot_limit?
          add_robot(robot_name(str))
          set_current_robot(robot_name(str))
        else
          puts 'Reach Robot limit!'
          return false
        end
      end
      attrs = str.split(' ').last.split(',')
      res = place_robot(attrs[0],attrs[1],attrs[2])
    end

    def place_robot(x, y ,direction)
      return false if new_position_collided?('place', {x: x,y: y})
      @current_robot.place(x, y ,direction)
      @current_robot.state = 'active'
      true
    end

    def turn_robot_on_board(str, towards)
      if robot_exist?(robot_name(str)) && get_robot_by_name(robot_name(str)).is_active?
        set_current_robot(robot_name(str))
        @current_robot.turn(towards)
        true
      else
        puts 'Please use a existing robot and place it to board'
        false
      end
    end

    def move_robot_on_board(str)
      if robot_exist?(robot_name(str)) && get_robot_by_name(robot_name(str)).is_active?
        set_current_robot(robot_name(str))
        if new_position_collided?('move', {move: 1})
          puts 'Can not move the robot'
          false
        else
          @current_robot.move
          true
        end
      else
        puts 'Please use an existing robot and place it to board'
        false
      end
    end

    def display_robots
      if @existing_robots.count > 0
        @existing_robots.each_with_index do |robot, i|
          puts "#{robot.name}: #{robot.x},#{robot.y},#{robot.direction.upcase}"
        end
      else
        puts "No robot on the board"
      end
    end

  end
end