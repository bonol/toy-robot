require_relative '../../lib/toy_robot_game'

describe ToyRobotGame::Command do
  context 'START' do
    it 'processes START' do
      command, *args = described_class.process('START')
      expect(command).to eq(:start_game)
      expect(args).to be_empty
    end
  end

  context 'LIST ROBOTS' do
    it 'processes LIST ROBOTS' do
      command, *args = described_class.process('LIST ROBOTS')
      expect(command).to eq(:display_robots)
      expect(args).to be_empty
    end
  end

  context 'PLACE' do
    it 'processes PLACE' do
      command, *args = described_class.process('OLE: PLACE 1,2,NORTH')
      expect(command).to eq(:place)
      expect(args).to eq ['OLE', 1, 2, 'NORTH']
    end

    it 'returns :invalid for an invalid PLACE command' do
      command = described_class.process('PLACE 1, 2, NORTH')
      expect(command).to eq([:invalid, 'PLACE 1, 2, NORTH'])
    end
  end

  context 'MOVE' do
    it 'processes MOVE' do
      command, *args = described_class.process('OLE: MOVE')

      expect(command).to eq :move
      expect(args).to eq ['OLE']
    end
  end

  context 'LEFT' do
    it 'processes the command' do
      command, *args = described_class.process('OLE: LEFT')

      expect(command).to eq :turn_left
      expect(args).to eq ['OLE']
    end
  end

  context 'RIGHT' do
    it 'processes the command' do
      command, *args = described_class.process('OLE: RIGHT')

      expect(command).to eq :turn_right
      expect(args).to eq ['OLE']
    end
  end

  context 'REPORT' do
    it 'processes the command' do
      command, *args = described_class.process('OLE: REPORT')

      expect(command).to eq :report
      expect(args).to eq ['OLE']
    end
  end
end