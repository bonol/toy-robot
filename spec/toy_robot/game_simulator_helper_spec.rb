require_relative '../../lib/toy_robot_game'

describe ToyRobotGame::GameSimulatorHelper do
  let(:game_board) { ToyRobotGame::GameBoard.new(6,6) }
  let(:simulator) { ToyRobotGame::GameSimulator.new(game_board) }
  describe 'valid_place_attrs?' do
    context 'without robot added to board' do
      it 'return true if place_attr are valid' do
        expect(simulator.valid_place_attrs?(2, 3, 'NORTH')).to be_truthy
      end
      it 'return false if attrs direction invalid' do
        expect(simulator.valid_place_attrs?(2,3 ,'somewhere')).to be_falsey
      end
      it 'return false if attrs coordination invalid' do
        expect(simulator.valid_place_attrs?(8, 3, 'east')).to be_falsey
      end
      it 'return false if attrs coordination invalid' do
        expect(simulator.valid_place_attrs?(3, 8, 'east')).to be_falsey
      end
    end
  end

  describe 'new_position_collided?' do
    context 'action place' do
      it 'return false without robot on game board' do
        expect(simulator.new_position_collided?('place', {x: '3', y: '4'})).to be_falsey
      end
      it 'return true with existing robot on the location' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('2','2','north')
        simulator.existing_robots = [robbie]
        expect(simulator.new_position_collided?('place', {x: '2', y: '2'})).to be_truthy
      end
    end
    context 'action move' do
      it 'return false when facing north with valid action' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('2','2','north')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('3', '4', 'south')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_falsey
      end
      it 'return true when facing north with invalid action' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','5','north')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('3', '4', 'south')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing north with invalid action' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','1','north')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('0', '2', 'south')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return false when facing south with valid action' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','2','south')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('3', '4', 'south')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_falsey
      end
      it 'return true when facing south with invalid action' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','2','south')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('0', '1', 'east')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing south with invalid action - fall off board' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','0','south')
        ole = ToyRobotGame::Robot.new('ole')
        ole.place('0', '4', 'east')
        simulator.existing_robots = [robbie, ole]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing east with invalid action - fall off board' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('5','5','east')
        simulator.existing_robots = [robbie]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
      it 'return true when facing west with invalid action - fall off board' do
        robbie = ToyRobotGame::Robot.new('robbie')
        robbie.place('0','5','west')
        simulator.existing_robots = [robbie]
        simulator.set_current_robot('robbie')
        expect(simulator.new_position_collided?('move', {move: 1})).to be_truthy
      end
    end
  end

  describe 'get_robot_by_name' do
    it 'get the right robot' do
      robbie = ToyRobotGame::Robot.new('robbie')
      ole = ToyRobotGame::Robot.new('ole')
      simulator.existing_robots = [robbie, ole]
      expect(simulator.get_robot_by_name('ole')).to be(ole)
    end
  end

  describe 'robot_exist?' do
    it 'return true if exist' do
      robbie = ToyRobotGame::Robot.new('robbie')
      ole = ToyRobotGame::Robot.new('ole')
      simulator.existing_robots = [robbie, ole]
      expect(simulator.robot_exist?('ole')).to be_truthy
    end
    it 'return false if not exist' do
      robbie = ToyRobotGame::Robot.new('robbie')
      ole = ToyRobotGame::Robot.new('ole')
      simulator.existing_robots = [robbie, ole]
      expect(simulator.robot_exist?('hulk')).to be_falsey
    end
  end

  describe 'collide_with_robot?' do
    before { simulator.start_game }
    it 'return true if vision collide with ole when facing north' do
      simulator.place('ole', 1,1, 'NORTH')
      simulator.place('vision',1, 0, 'NORTH')
      expect(simulator.collide_with_robot?(1)).to be_truthy
    end
    it 'return true if vision collide with ole when facing east' do
      simulator.place('ole', 1, 1, 'NORTH')
      simulator.place('vision', 0, 1, 'east')
      expect(simulator.collide_with_robot?(1)).to be_truthy
    end
    it 'return true if vision collide with ole when facing south' do
      simulator.place('ole', 1, 1, 'NORTH')
      simulator.place('vision', 1, 2, 'SOUTH')
      expect(simulator.collide_with_robot?(1)).to be_truthy
    end
    it 'return true if vision collide with ole when facing west' do
      simulator.place('ole', 1, 1, 'WEST')
      simulator.place('vision', 2, 1, 'WEST')
      expect(simulator.collide_with_robot?(1)).to be_truthy
    end
    it 'return false if vision not collide with ole when facing west' do
      simulator.place('ole', 2, 2, 'WEST')
      simulator.place('vision', 2, 1, 'WEST')
      expect(simulator.collide_with_robot?(1)).to be_falsey
    end
  end
end