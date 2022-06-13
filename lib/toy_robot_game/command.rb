require_relative '../toy_robot_game'
require 'English'

module ToyRobotGame
  class Command
    def self.process(command)
      case command
      when /START\z/i
        [:start]
      when /LIST\sROBOTS\z/i
        [:list_robots]
      when /CURRENT\z/i
        [:current]
      when /\Aplace\s(?<robot>\w+)\s(?<x>\d+),(?<y>\d+),(?<direction>\w+)\z/i
        [:place, $LAST_MATCH_INFO[:robot], $LAST_MATCH_INFO[:x].to_i, $LAST_MATCH_INFO[:y].to_i, $LAST_MATCH_INFO[:direction]]
      when /LEFT\z/i
        [:left]
      when /\ALEFT\s(?<robot>\w+\z)/i
        [:left, $LAST_MATCH_INFO[:robot]]
      when /RIGHT\z/i
        [:right]
      when /\ARIGHT\s(?<robot>\w+\z)/i
        [:right, $LAST_MATCH_INFO[:robot]]
      when /REPORT\z/i
        [:report]
      when /\AREPORT\s(?<robot>\w+\z)/i
        [:report, $LAST_MATCH_INFO[:robot]]
      when /MOVE\z/i
        [:move]
      when /\AMOVE\s(?<robot>\w+\z)/i
        [:move, $LAST_MATCH_INFO[:robot]]
      when /HELP\z/i
        [:help]
      when /EXIT\z/i
        puts 'exit game now'
        exit
      else
        [:invalid, command]
      end
    end

  end
end