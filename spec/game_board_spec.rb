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

end