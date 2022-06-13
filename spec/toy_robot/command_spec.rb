require_relative '../../lib/toy_robot_game'

describe ToyRobotGame::Command do
  
  context 'Valid commands without robot name' do
    ['START', 'LIST ROBOTS', 'REPORT', 'MOVE', 'LEFT', 'RIGHT'].each do |command|
      it "processes #{command}" do
        cmd, *args = described_class.process(command)
        expect(cmd).to eq(command.downcase.tr(' ', '_').to_sym)
        expect(args).to be_empty
      end
    end
  end

  context 'Invalid commands without robot name' do
    ['START  ', 'LIST   ROBOTS', 'REPORTabc', 'MOVE name 123', 'LEFT name   '].each do |command|
      it "processes #{command}" do
        cmd, *args = described_class.process(command)
        expect(cmd).to eq(:invalid)
      end
    end
  end

  context 'PLACE' do
    it 'processes PLACE' do
      command, *args = described_class.process('PLACE OLE 1,2,NORTH')
      expect(command).to eq(:place)
      expect(args).to eq ['OLE', 1, 2, 'NORTH']
    end

    it 'returns :invalid for an invalid PLACE command' do
      command = described_class.process('PLACE 1, 2, NORTH')
      expect(command).to eq([:invalid, 'PLACE 1, 2, NORTH'])
    end
  end

  context 'MOVE' do
    it 'processes MOVE with robot name' do
      command, *args = described_class.process('MOVE OLE')

      expect(command).to eq :move
      expect(args).to eq ['OLE']
    end
  end

  context 'LEFT' do
    it 'processes the command with robot name' do
      command, *args = described_class.process('LEFT OLE')

      expect(command).to eq :left
      expect(args).to eq ['OLE']
    end
  end

  context 'RIGHT' do
    it 'processes the command' do
      command, *args = described_class.process('RIGHT OLE')

      expect(command).to eq :right
      expect(args).to eq ['OLE']
    end
  end

  context 'REPORT' do
    it 'processes the command with robot name' do
      command, *args = described_class.process('REPORT OLE')

      expect(command).to eq :report
      expect(args).to eq ['OLE']
    end
  end
end