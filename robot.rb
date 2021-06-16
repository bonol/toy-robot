class Robot
  attr_accessor :name, :state, :x, :y, :direction
  DIRECTIONS = ['east', 'south', 'west', 'north']
  def initialize(name)
    @name = name
    @state = 'standby'
    @x = 0
    @y = 0
    @direction = ''
  end

  def turn(towards)
    idx = DIRECTIONS.index{|d| @direction == d }
    if towards == 'left'
      @direction =  DIRECTIONS[idx - 1]
    else
      @direction = idx == 3 ? DIRECTIONS[0] : DIRECTIONS[idx + 1]
    end
  end

  def report
    puts "Robot #{@name} | Position x #{@x} | Position y #{@y} | Towards #{@direction}"
  end

  def move(steps=1)
    case @direction
    when 'north'
      @y = @y + steps
    when 'south'
      @y = @y - steps
    when 'east'
      @x = @x + steps
    when 'west'
      @x = @x - steps
    end
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