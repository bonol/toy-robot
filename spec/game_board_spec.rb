require './toy_robot_game'

describe ToyRobotGame::GameBoard do
  let(:game_board) {ToyRobotGame::GameBoard.new(6,6)}

  describe 'add_robot' do
    it 'will add vision' do
      expect(game_board.existing_robots.count).to be(0)
      game_board.add_robot('vision')
      expect(game_board.existing_robots.count).to be(1)
    end
  end

  describe 'set_current_robot' do
    it 'will set vision as current' do
      game_board.add_robot('vision')
      game_board.set_current_robot('vision')
      expect(game_board.current_robot.name).to eq('vision')
    end
  end

  describe 'place_robot' do
    it 'will place vision on board' do
      robbie = Robot.new('rob')
      robbie.place('0','0','south')
      ole = Robot.new('ole')
      ole.place('0', '4', 'east')
      vision = Robot.new('vision')
      game_board.existing_robots = [robbie, ole, vision]
      game_board.set_current_robot('vision')
      expect(game_board.place_robot('4', '5', 'north')).to be_truthy
    end
    it 'will not place vision on board - position already taken' do
      robbie = Robot.new('rob')
      robbie.place('0','0','south')
      ole = Robot.new('ole')
      ole.place('0', '4', 'east')
      vision = Robot.new('vision')
      game_board.existing_robots = [robbie, ole, vision]
      game_board.set_current_robot('vision')
      expect(game_board.place_robot('0', '0', 'north')).to be_falsey
    end
  end

  describe 'place_robot_on_board' do
    it 'return true on place robot succeeded - new robot' do
      expect(game_board.existing_robots.count).to eq(0)
      expect(game_board.place_robot_on_board('vision: PLACE 1,1,NORTH')).to be_truthy
      expect(game_board.existing_robots.count).to eq(1)
    end
    it 'return true on place robot succeeded - existing robot' do
      vision = Robot.new('vision')
      game_board.existing_robots = [vision]
      expect(game_board.existing_robots.count).to eq(1)
      expect(game_board.place_robot_on_board('vision: PLACE 1,1,NORTH')).to be_truthy
      expect(game_board.existing_robots.count).to eq(1)
    end
    it 'return false if place attrs are invalid' do
      expect(game_board.place_robot_on_board('vision: PLACE 7,1,NORTH')).to be_falsey
    end
    it 'return false if reach robot limit' do
      ole = Robot.new('ole')
      36.times{game_board.existing_robots << ole.dup}
      expect(game_board.place_robot_on_board('vision: PLACE 1,1,NORTH')).to be_falsey
    end
  end

  describe 'move_robot_on_board' do
    it 'return true when move robot succeeded' do
      game_board.place_robot_on_board('vision: PLACE 1,1,NORTH')
      expect(game_board.move_robot_on_board('vision: MOVE')).to be_truthy
    end
    it 'return false when robot not exist' do
      expect(game_board.move_robot_on_board('vision: MOVE')).to be_falsey
    end
    it 'return false when robot is not placed/active' do
      vision = Robot.new('vision')
      game_board.existing_robots = [vision]
      expect(game_board.move_robot_on_board('vision: MOVE')).to be_falsey
    end
    it 'return false when new position invalid - fall off board' do
      game_board.place_robot_on_board('vision: PLACE 5,5,NORTH')
      expect(game_board.move_robot_on_board('vision: MOVE')).to be_falsey
    end
    it 'return false when new position invalid - collide with other robot' do
      game_board.place_robot_on_board('vision: PLACE 2,2,NORTH')
      game_board.place_robot_on_board('ole: PLACE 2,1,NORTH')
      expect(game_board.move_robot_on_board('ole: MOVE')).to be_falsey
    end
  end

end