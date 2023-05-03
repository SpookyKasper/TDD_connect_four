require_relative '../lib/connect_four_player.rb'

describe Player do
  describe '#pick_color' do
    let(:player) { described_class.new }

    context 'when player picks black by typing 1' do

      before do
        choice = '1'
        allow(player).to receive(:gets).and_return(choice)
      end

      it 'sets player color to black smiley unicode value' do
        player.pick_color
        black_smiley_unicode = "\u263A"
        result = player.instance_variable_get(:@color)
        expect(result).to eq(black_smiley_unicode)
      end
    end

    context 'when player picks white by typing 2' do

      before do
        choice = '2'
        allow(player).to receive(:gets).and_return(choice)
      end

      it 'sets player color to white smilye unicode value' do
        player.pick_color
        white_smiley_unicode = "\u263B"
        result = player.instance_variable_get(:@color)
        expect(result).to eq(white_smiley_unicode)
      end
    end
  end
end


