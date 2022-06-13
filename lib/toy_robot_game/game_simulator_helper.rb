#game simulator helper methods
module ToyRobotGame
  module GameSimulatorHelper
    def valid_direction?(direction)
      Robot::DIRECTIONS.include?(direction.downcase)
    end

    def is_game_on?
      @game_state == 'playing'
    end

    def add_robot(name)
      new_robot = Robot.new(name)
      @existing_robots << new_robot
    end

    def within_robot_limit?
      @board.col_num * @board.row_num > @existing_robots.count
    end

    def new_position_collided?(action, attrs)
      case action
      when 'place'
        @existing_robots.any? { |robot| robot.x == attrs[:x].to_i && robot.y == attrs[:y].to_i }
      when 'move'
        case @current_robot.direction.downcase
        when 'north'
          (@current_robot.y.to_i + attrs[:move] >= @board.row_num) || collide_with_robot?(attrs[:move])
        when 'south'
          (@current_robot.y.to_i - attrs[:move]).negative? || collide_with_robot?(attrs[:move])
        when 'east'
          (@current_robot.x + attrs[:move] >= @board.col_num) || collide_with_robot?(attrs[:move])
        when 'west'
          (@current_robot.x - attrs[:move]).negative? || collide_with_robot?(attrs[:move])
        else
          true
        end
      end
    end

    def collide_with_robot?(move)
      case @current_robot.direction.downcase
      when 'north'
        @existing_robots.any? { |robot| (robot.name != @current_robot.name) && is_dimension_collided?(robot, :y, :+, move) && (robot.x.to_i == @current_robot.x.to_i) }
      when 'south'
        @existing_robots.any? { |robot| (robot.name != @current_robot.name) && is_dimension_collided?(robot, :y, :-, move) && (robot.x.to_i == @current_robot.x.to_i) }
      when 'east'
        @existing_robots.any? { |robot| (robot.name != @current_robot.name) && is_dimension_collided?(robot, :x, :+, move) && (robot.y.to_i == @current_robot.y.to_i) }
      when 'west'
        @existing_robots.any? { |robot| (robot.name != @current_robot.name) && is_dimension_collided?(robot, :x, :-, move) && (robot.y.to_i == @current_robot.y.to_i) }
      else
        true
      end
    end

    def is_dimension_collided?(robot, dimension, operator, move)
      robot.send(dimension).to_i == @current_robot.send(dimension).to_i.send(operator, move)
    end

    def set_current_robot(robot_name)
      @current_robot = get_robot_by_name robot_name
    end

    def get_robot_by_name(robot_name)
      @existing_robots.find { |robot| robot.name == robot_name }
    end

    def robot_exist?(robot_name)
      @existing_robots.any? { |robot| robot.name == robot_name }
    end

    def update_existing(x, y ,direction)
      robot = @existing_robots.find { |robot| robot.name == @current_robot.name }
      robot.x = x
      robot.y = y
      robot.direction = direction
    end

    def valid_place_attrs?(x, y, direction)
      return false unless valid_direction?(direction)
      return false unless @board.valid_board_position?(x, y)
      true
    end
  end
end