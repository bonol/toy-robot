require_relative '../lib/toy_robot_game/game_board'
require_relative '../lib/toy_robot_game/game_simulator_helper'
require_relative '../lib/toy_robot_game/game_simulator'
require_relative '../lib/toy_robot_game/info_presenter'
require_relative '../lib/toy_robot_game/robot'
require_relative '../lib/toy_robot_game/cli'
require_relative '../lib/toy_robot_game/command'

module ToyRobotGame
    class RobotError < StandardError; end
end