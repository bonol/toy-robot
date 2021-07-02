require_relative '../../lib/toy_robot_game'

describe ToyRobotGame::Robot do
  let(:game_board) {ToyRobotGame::GameBoard.new(6,6)}
  let(:vision) {ToyRobotGame::Robot.new('vision')}
  describe 'turn' do
    it 'turn left' do
      vision.place('0', '0','south')
      vision.turn('left')
      expect(vision.direction).to eq('east')
    end

    it 'turn right' do
      vision.place('0', '0','south')
      vision.turn('right')
      expect(vision.direction).to eq('west')
    end
  end

  describe 'move' do
    it 'will move 1 unit north' do
      vision.place('0', '0','north')
      vision.move
      expect(vision.y).to eq(1)
    end
    it 'will move 2 unit east' do
      vision.place('0', '0','east')
      vision.move(2)
      expect(vision.x).to eq(2)
    end
    it 'will move 1 unit south' do
      vision.place('0', '3','south')
      vision.move
      expect(vision.y).to eq(2)
    end
    it 'will move 1 unit west' do
      vision.place('5', '5','west')
      vision.move
      expect(vision.x).to eq(4)
    end
  end

  describe 'place' do
    it 'set robot attributes' do
      vision.place('0', '3','south')
      expect(vision.x).to eq(0)
      expect(vision.y).to eq(3)
      expect(vision.direction).to eq('south')
    end
  end

end