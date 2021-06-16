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

    alias restart_game start_game

    def add_robot(name)
      new_robot = Robot.new(name)
      @existing_robots << new_robot
    end

    def set_current_robot(robot_name)
      @current_robot = get_robot_by_name robot_name
    end

    # methods to play game
    def place_robot(x, y ,direction)
      return false if new_position_collided?('place', {x: x,y: y})
      @current_robot.place(x, y ,direction)
      # update_existing(x, y ,direction)
      @current_robot.state = 'active'
      true
    end

    def display_robots
      if @existing_robots.count > 0
        @existing_robots.each_with_index do |robot, i|
          puts "No #{i} | #{robot.name} | state: #{robot.state} | position x: #{robot.x} | position y: #{robot.y} | direction #{robot.direction}"
        end
        puts "Current active robot is #{current_robot.name} | state #{current_robot.state} | position x: #{current_robot.x} | position y: #{current_robot.y} | direction #{current_robot.direction}" if current_robot
      else
        puts "No robot on the board"
      end
    end

  end
end