require './toy_robot_game'

describe ToyRobotGame::GameBoardHelper do
  let(:game_board) {ToyRobotGame::GameBoard.new(6,6)}
  describe 'valid_place_attrs?' do
    context 'without robot added to board' do
      it 'return true if place_attr are valid' do
        expect(game_board.valid_place_attrs?('place 2,3,north')).to be_truthy
      end

      it 'return false if attrs seperator format invalid' do
        expect(game_board.valid_place_attrs?('place 2 3 north')).to be_falsey
      end

      it 'return false if attrs number invalid' do
        expect(game_board.valid_place_attrs?('place 2,3')).to be_falsey
      end

      it 'return false if attrs direction invalid' do
        expect(game_board.valid_place_attrs?('place 2,3,somewhere')).to be_falsey
      end

      it 'return false if attrs coordination invalid' do
        expect(game_board.valid_place_attrs?('place 8,3,east')).to be_falsey
      end

      it 'return false if attrs coordination invalid' do
        expect(game_board.valid_place_attrs?('place 3,8,east')).to be_falsey
      end
    end
  end

  describe 'invalid_board_position' do
    it 'return false if attrs is valid' do
      expect(game_board.invalid_board_position('3','5','North')).to be_falsey
    end
    it 'return false if attrs is valid' do
      expect(game_board.invalid_board_position('3','5','south')).to be_falsey
    end
    it 'return true if direction is invalid' do
      expect(game_board.invalid_board_position('3','5','random')).to be_truthy
    end
    it 'return true if coordination is invalid' do
      expect(game_board.invalid_board_position('7','5','North')).to be_truthy
    end
  end

  describe 'new_position_collided?' do
    context 'action place' do
      it 'return false without robot on game board' do
        expect(game_board.new_position_collided?('place', {x: '3', y: '4'})).to be_falsey
      end
      it 'return true with existing robot on the location' do
        robbie = Robot.new('robbie')
        robbie.place('2','2','north')
        game_board.existing_robots = [robbie]
        expect(game_board.new_position_collided?('place', {x: '2', y: '2'})).to be_truthy
        game_board.existing_robots = []
      end
    end
  end
end