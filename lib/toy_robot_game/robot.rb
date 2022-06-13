module ToyRobotGame
  class Robot
    attr_accessor :name, :state, :x, :y, :direction
    DIRECTIONS = ['east', 'south', 'west', 'north']
    def initialize(name)
      @name = name
      @state = 'standby'
      @x = ''
      @y = ''
      @direction = ''
    end

    def turn(towards)
      idx = DIRECTIONS.index{|d| @direction.downcase == d }
      if towards == 'left'
        @direction =  DIRECTIONS[idx - 1]
      else
        @direction = idx == 3 ? DIRECTIONS[0] : DIRECTIONS[idx + 1]
      end
      true
    end

    def report
      puts "#{@name}: #{@x}, #{@y}, #{@direction.upcase}"
    end

    def move(steps=1)
      case @direction.downcase
      when 'north'
        @y = @y + steps
      when 'south'
        @y = @y - steps
      when 'east'
        @x = @x + steps
      when 'west'
        @x = @x - steps
      end
      true
    end

    def place(x,y,direction)
      @x = x.to_i
      @y = y.to_i
      @direction = direction
    end

    def is_active?
      @state == 'active'
    end
  end
end