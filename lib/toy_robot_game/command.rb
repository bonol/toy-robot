require_relative '../toy_robot_game'
require 'English'

module ToyRobotGame
  class Command
    def self.process(command)
      case command
      when /START/i
        [:start_game]
      when /LIST\sROBOTS/i
        [:display_robots]
      when /\A(?<robot>\w+):\sPLACE\s(?<x>\d+),(?<y>\d+),(?<direction>\w+)\Z/i
        [:place, $LAST_MATCH_INFO[:robot], $LAST_MATCH_INFO[:x].to_i, $LAST_MATCH_INFO[:y].to_i, $LAST_MATCH_INFO[:direction]]
      when /(?<robot>\w+):\sLEFT/i
        [:turn_left, $LAST_MATCH_INFO[:robot]]
      when /(?<robot>\w+):\sRIGHT/i
        [:turn_right, $LAST_MATCH_INFO[:robot]]
      when /(?<robot>\w+):\sREPORT/i
        [:report, $LAST_MATCH_INFO[:robot]]
      when /(?<robot>\w+):\sMOVE/i
        [:move, $LAST_MATCH_INFO[:robot]]
      when /HELP/i
        [:help]
      when /EXIT/i
        puts 'exit game now'
        exit
      else
        [:invalid, command]
      end
    end

  end
end