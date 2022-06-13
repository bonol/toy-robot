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

    alias_method :start, :start_game

    def list_robots
      raise ToyRobotGame::RobotError, 'No robot on the board' unless @existing_robots.count.positive?

      @existing_robots.each do |robot|
        puts "#{robot.name}: #{robot.x},#{robot.y},#{robot.direction.upcase}"
      end
    end

    def current
      raise ToyRobotGame::RobotError, 'Game not started. No robot places on board.' unless is_game_on?
      puts "current robot is #{@current_robot&.name}"
    end

    def place(robot_name, x, y, direction)
      raise ToyRobotGame::RobotError, 'Please start a new game' unless is_game_on?
      raise ToyRobotGame::RobotError, 'PLACE robot failed - invalid attributes' unless valid_place_attrs?(x, y, direction)
      raise ToyRobotGame::RobotError, 'Reach Robot limit!' unless within_robot_limit?
      raise ToyRobotGame::RobotError, 'Robot already on board' if robot_exist?(robot_name)
      raise ToyRobotGame::RobotError, 'PLACE robot failed - position already taken' if new_position_collided?('place', { x: x,y: y })

      add_robot(robot_name)
      set_current_robot(robot_name)
      @current_robot.place(x, y ,direction)
      puts 'PLACE robot succeeded'
    end

    def left(robot_name=nil)
      raise ToyRobotGame::RobotError, 'Please start a new game' unless is_game_on?
      robot_name ||= @current_robot&.name
      raise ToyRobotGame::RobotError, 'Please use an existing robot' unless robot_exist?(robot_name)

      set_current_robot(robot_name)
      @current_robot.turn('left')
    end

    def right(robot_name=nil)
      raise ToyRobotGame::RobotError, 'Please start a new game' unless is_game_on?
      robot_name ||= @current_robot&.name
      raise ToyRobotGame::RobotError, 'Please use an existing robot' unless robot_exist?(robot_name)

      set_current_robot(robot_name)
      @current_robot.turn('right')
    end

    def report(robot_name=nil)
      raise ToyRobotGame::RobotError, 'Please start a new game' unless is_game_on?
      robot_name ||= @current_robot&.name
      raise ToyRobotGame::RobotError, 'Please use an existing robot' unless robot_exist?(robot_name)

      set_current_robot(robot_name)
      @current_robot.report
    end

    def move(robot_name=nil)
      raise ToyRobotGame::RobotError, 'Please start a new game' unless is_game_on?
      robot_name ||= @current_robot&.name
      raise ToyRobotGame::RobotError, 'Please use an existing robot' unless robot_exist?(robot_name)

      set_current_robot(robot_name)
      raise ToyRobotGame::RobotError, 'Invalid move' if new_position_collided?('move', { move: 1 })
      @current_robot.move
    end
  end
end