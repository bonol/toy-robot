require_relative '../../lib/toy_robot_game'

describe ToyRobotGame::GameBoard do
  let(:game_board) {ToyRobotGame::GameBoard.new(6,6)}

  describe 'valid_board_position?' do
    it 'return true if position is valid' do
      expect(game_board.valid_board_position?(3, 5)).to be_truthy
    end
    it 'return false if position is invalid' do
      expect(game_board.valid_board_position?(20, 5)).to be_falsey
    end
  end

end