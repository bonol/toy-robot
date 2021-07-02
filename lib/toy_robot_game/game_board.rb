require_relative '../toy_robot_game'

module ToyRobotGame
  class GameBoard
    attr_accessor :col_num, :row_num

    def initialize(x,y)
      @col_num = x
      @row_num = y
    end

    def valid_board_position?(x, y)
      return false if x.to_i < 0 || x.to_i >= @col_num
      return false if y.to_i < 0 || y.to_i >= @row_num
      true
    end
  end
end