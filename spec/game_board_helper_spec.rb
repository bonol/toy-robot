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
    it 'return true if coordination is invalid' do
      expect(game_board.invalid_board_position('-7','5','North')).to be_truthy
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
      end
    end
    context 'action move' do
      it 'return false when facing north with valid action' do
        robbie = Robot.new('robbie')
        robbie.place('2','2','north')
        ole = Robot.new('ole')
        ole.place('3', '4', 'south')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_falsey
      end
      it 'return true when facing north with invalid action' do
        robbie = Robot.new('robbie')
        robbie.place('0','5','north')
        ole = Robot.new('ole')
        ole.place('3', '4', 'south')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing north with invalid action' do
        robbie = Robot.new('robbie')
        robbie.place('0','1','north')
        ole = Robot.new('ole')
        ole.place('0', '2', 'south')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return false when facing south with valid action' do
        robbie = Robot.new('robbie')
        robbie.place('0','2','south')
        ole = Robot.new('ole')
        ole.place('3', '4', 'south')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_falsey
      end
      it 'return true when facing south with invalid action' do
        robbie = Robot.new('robbie')
        robbie.place('0','2','south')
        ole = Robot.new('ole')
        ole.place('0', '1', 'east')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing south with invalid action - fall off board' do
        robbie = Robot.new('robbie')
        robbie.place('0','0','south')
        ole = Robot.new('ole')
        ole.place('0', '4', 'east')
        game_board.existing_robots = [robbie, ole]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing east with invalid action - fall off board' do
        robbie = Robot.new('robbie')
        robbie.place('5','5','east')
        game_board.existing_robots = [robbie]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing west with invalid action - fall off board' do
        robbie = Robot.new('robbie')
        robbie.place('0','5','west')
        game_board.existing_robots = [robbie]
        game_board.set_current_robot('robbie')
        expect(game_board.new_position_collided?('move', {move: 1})).to be_truthy
      end
    end
  end

  describe 'get_robot_by_name' do
    it 'get the right robot' do
      robbie = Robot.new('robbie')
      ole = Robot.new('ole')
      game_board.existing_robots = [robbie, ole]
      expect(game_board.get_robot_by_name('ole')).to be(ole)
    end
  end

  describe 'robot_exist?' do
    it 'return true if exist' do
      robbie = Robot.new('robbie')
      ole = Robot.new('ole')
      game_board.existing_robots = [robbie, ole]
      expect(game_board.robot_exist?('ole')).to be_truthy
    end
    it 'return false if not exist' do
      robbie = Robot.new('robbie')
      ole = Robot.new('ole')
      game_board.existing_robots = [robbie, ole]
      expect(game_board.robot_exist?('hulk')).to be_falsey
    end
  end
end