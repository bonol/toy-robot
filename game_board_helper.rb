#game board helper methods
module ToyRobotGame
  module GameBoardHelper
    def valid_direction?(direction)
      Robot::DIRECTIONS.include?(direction.downcase)
    end

    def is_game_on?
      @game_state == 'playing'
    end

    def within_robot_limit?
      @col_num * @row_num > @existing_robots.count
    end

    def invalid_board_position(x, y, direction)
      return true if x.to_i < 0 || x.to_i >= @col_num
      return true if y.to_i < 0 || y.to_i >= @row_num
      return true unless Robot::DIRECTIONS.include?(direction.downcase)
      false
    end

    def new_position_collided?(action, attrs)
      if action == 'place'
        @existing_robots.any? {|robot| robot.x == attrs[:x].to_i && robot.y == attrs[:y].to_i}
      elsif action == 'move'
        case @current_robot.direction.downcase
        when 'north'
          (@current_robot.y.to_i + attrs[:move] >= @row_num) || collide_with_robot?(attrs[:move])
        when 'south'
          (@current_robot.y.to_i - attrs[:move] < 0) || collide_with_robot?(attrs[:move])
        when 'east'
          (@current_robot.x + attrs[:move] >= @col_num) || collide_with_robot?(attrs[:move])
        when 'west'
          (@current_robot.x - attrs[:move] < 0) || collide_with_robot?(attrs[:move])
        else
          true
        end
      end
    end

    def collide_with_robot?(move)
      case @current_robot.direction.downcase
      when 'north'
        @existing_robots.reject{|robot| robot.name == @current_robot.name}.
            any?{|robot| (robot.y.to_i == @current_robot.y.to_i + move) && (robot.x.to_i == @current_robot.x.to_i) }
      when 'south'
        @existing_robots.reject{|robot| robot.name == @current_robot.name}.
            any?{|robot| (robot.y.to_i == @current_robot.y.to_i - move) && (robot.x.to_i == @current_robot.x.to_i) }
      when 'east'
        @existing_robots.reject{|robot| robot.name == @current_robot.name}.
            any?{|robot| (robot.x.to_i == @current_robot.x.to_i + move) && (robot.y.to_i == @current_robot.y.to_i) }
      when 'west'
        @existing_robots.reject{|robot| robot.name == @current_robot.name}.
            any?{|robot| (robot.x.to_i == @current_robot.x.to_i - move ) && (robot.y.to_i == @current_robot.y.to_i) }
      else
        true
      end
    end

    def get_robot_by_name(robot_name)
      @existing_robots.find{|robot| robot.name == robot_name}
    end

    def robot_exist?(robot_name)
      @existing_robots.any?{|robot| robot.name == robot_name}
    end

    def update_existing(x, y ,direction)
      robot = @existing_robots.find{|robot| robot.name == @current_robot.name}
      robot.x = x
      robot.y = y
      robot.direction = direction
    end

    def valid_place_attrs?(place_attr)
      return false unless place_attr.split(' ').count == 3
      attrs = place_attr.split(' ').last.split(',')
      return false unless attrs.count == 3
      return false unless valid_direction?(attrs[2])
      return false if invalid_board_position(attrs[0], attrs[1], attrs[2])
      true
    end

    def robot_name(str)
      str.split(' ').first.delete_suffix(':')
    end
  end
end