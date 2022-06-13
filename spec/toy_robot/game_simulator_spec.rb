require_relative '../../lib/toy_robot_game'
RSpec.shared_examples 'display message' do |klass|
  it "display "
end
describe ToyRobotGame::GameSimulator do
  let(:game_board) { ToyRobotGame::GameBoard.new(6,6) }
  let(:simulator) { ToyRobotGame::GameSimulator.new(game_board) }

  describe 'invalid' do
    it 'receive invalid message' do
      $stdout = StringIO.new
      simulator.invalid('invalid cmd')
      $stdout.rewind
      expect($stdout.gets.strip).to include 'invalid cmd'
    end
  end

  describe 'list_robots' do
    it 'display existing robot' do
      robbie = ToyRobotGame::Robot.new('robbie')
      simulator.existing_robots = [robbie]
      $stdout = StringIO.new
      simulator.list_robots
      $stdout.rewind
      expect($stdout.gets.strip).to include 'robbie'
    end
    it 'display no robot message' do
      simulator.existing_robots = []
      expect { simulator.list_robots }.to raise_error('No robot on the board')
    end
  end

  describe 'place' do
    before { simulator.start_game }

    it 'display failed - invalid dimension' do
      expect { simulator.place('robbie', 10, 3, 'north') }.to raise_error('PLACE robot failed - invalid attributes')
    end
    it 'display failed - invalid direction' do
      expect { simulator.place('robbie', 3, 3, 'random') }.to raise_error('PLACE robot failed - invalid attributes')
    end
    it 'place robot succeeded - new robot' do
      simulator.place('robbie', 3, 3, 'north')
      expect(simulator.current_robot.name).to eq 'robbie'
    end
    it 'place robot failed - robot already on board' do
      simulator.place('robbie', 3, 3, 'north')
      expect(simulator.existing_robots.count).to eq 1
      expect { simulator.place('robbie', 4, 4, 'north') }.to raise_error('Robot already on board')
      expect(simulator.existing_robots.count).to eq 1
    end
    it 'place robot failed - position taken' do
      simulator.place('ole', 3, 3, 'north')
      expect(simulator.existing_robots.count).to eq 1
      expect { simulator.place('robbie', 3, 3, 'north') }.to raise_error('PLACE robot failed - position already taken')
      expect(simulator.existing_robots.count).to eq 1
    end
    it 'display failed - reach robot limit' do
      ole = ToyRobotGame::Robot.new('ole')
      36.times{ simulator.existing_robots << ole.dup }
      expect { simulator.place('robbie', 3, 3, 'north') }.to raise_error('Reach Robot limit!')
    end
  end

  describe 'turn robot' do
    before { simulator.start_game }
    it 'turn left' do
      simulator.place('ole', 3, 3, 'north')
      expect(simulator.left('ole')).to be_truthy
      expect(simulator.get_robot_by_name('ole').direction).to eq 'west'
      expect(simulator.left).to be_truthy
      expect(simulator.get_robot_by_name('ole').direction).to eq 'south'
    end
    it 'turn right' do
      simulator.place('ole', 3, 3, 'north')
      expect(simulator.right('ole')).to be_truthy
      expect(simulator.get_robot_by_name('ole').direction).to eq 'east'
      expect(simulator.right).to be_truthy
      expect(simulator.get_robot_by_name('ole').direction).to eq 'south'
    end
    it 'none exist robot fail to turn right' do
      expect{ simulator.right('ole') }.to raise_error('Please use an existing robot')
    end
    it 'none exist robot fail to turn left' do
      expect{ simulator.left('ole') }.to raise_error('Please use an existing robot')
    end
  end

  describe 'report' do
    before { simulator.start_game }
    it 'report robot' do
      simulator.place('ole', 3, 3, 'north')
      $stdout = StringIO.new
      simulator.report('ole')
      $stdout.rewind
      expect($stdout.gets.strip).to include 'ole'
      simulator.report
      $stdout.rewind
      expect($stdout.gets.strip).to include 'ole'
    end
    it 'wont report none existing robot' do
      expect { simulator.report('ole') }.to raise_error('Please use an existing robot')
    end
  end

  describe 'move' do
    before { simulator.start_game }
    it 'wont move none existing robot' do
      expect { simulator.move('ole') }.to raise_error('Please use an existing robot')
    end
    it 'move robot' do
      simulator.place('ole', 3, 3, 'north')
      expect(simulator.move('ole')).to be_truthy
      expect(simulator.move).to be_truthy
    end
    it 'not move - position collided' do
      simulator.place('ole', 3, 3, 'north')
      simulator.place('rob', 3, 2, 'north')
      expect { simulator.move('rob') }.to raise_error('Invalid move')
    end
    it 'not move - fall off board' do
      simulator.place('ole', 5, 5, 'east')
      expect { simulator.move('ole') }.to raise_error('Invalid move')
    end
    it 'not move - fall off board' do
      simulator.place('ole', 5, 5, 'south')
      5.times{ simulator.move('ole') }
      expect { simulator.move('ole') }.to raise_error('Invalid move')
    end
    it 'not move - fall off board' do
      simulator.place('ole', 5, 5, 'south')
      5.times{ simulator.move('ole') }
      expect { simulator.move('ole') }.to raise_error('Invalid move')
    end
    it 'not move - fall off board' do
      simulator.place('ole', 0, 0, 'north')
      5.times{ simulator.move('ole') }
      expect { simulator.move('ole') }.to raise_error('Invalid move')
    end
    it 'not move - fall off board' do
      simulator.place('ole', 0, 0, 'east')
      5.times{ simulator.move('ole') }
      expect { simulator.move('ole') }.to raise_error('Invalid move')
    end
  end

end