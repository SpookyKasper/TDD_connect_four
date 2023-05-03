require_relative '../lib/connect_four_player.rb'

describe Player do
  describe '#pick_color' do
    let(:player) { described_class.new }

    context 'when player picks black by typing 1' do

      before do
        choice = '1'
        allow(player).to receive(:gets).and_return(choice)
        allow(player).to receive(:print_pick_color_message)
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
        allow(player).to receive(:print_pick_color_message)
      end

      it 'sets player color to white smilye unicode value' do
        player.pick_color
        white_smiley_unicode = "\u263B"
        result = player.instance_variable_get(:@color)
        expect(result).to eq(white_smiley_unicode)
      end
    end

    context 'when player types invalid input then valid input' do

      before do
        invalid_input = '3'
        valid_input = '2'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        allow(player).to receive(:print_pick_color_message)
      end

      it 'completes loop and displays error message once' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).to receive(:puts).with(error_message).once
        player.pick_color
      end
    end

    context 'when player types 3 invalid inputs and then a valid input' do

      before do
        invalid_input = 'A'
        invalid_input_2 = '0'
        invalid_input_3 = ''
        valid_input = '1'
        allow(player).to receive(:gets).and_return(invalid_input, invalid_input_2, invalid_input_3, valid_input)
        allow(player).to receive(:print_pick_color_message)
      end

      it 'completes loop and displays error message 3 times' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).to receive(:puts).with(error_message).thrice
        player.pick_color
      end
    end
  end
end


