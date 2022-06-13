require './lib/toy_robot_game'

cli = ToyRobotGame::CLI.new(ARGV[0], ARGV[1])
cli.start