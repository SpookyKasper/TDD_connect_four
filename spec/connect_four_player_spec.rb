require_relative '../lib/connect_four_player.rb'

describe Player do
  subject(:player) { described_class.new }

  describe '#pick_color' do
    context 'when player picks black by typing 1' do
      before do
        choice = '1'
        allow(player).to receive(:gets).and_return(choice)
        allow(player).to receive(:pick_color_message)
        player.pick_color
      end

      it 'sets player color to black smiley unicode value' do
        black_smiley_unicode = "\u263A"
        result = player.instance_variable_get(:@color)
        expect(result).to eq(black_smiley_unicode)
      end
    end

    context 'when player picks white by typing 2' do
      before do
        choice = '2'
        allow(player).to receive(:gets).and_return(choice)
        allow(player).to receive(:pick_color_message)
        player.pick_color
      end

      it 'sets player color to white smilye unicode value' do
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
        allow(player).to receive(:pick_color_message)
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
        allow(player).to receive(:pick_color_message)
      end

      it 'completes loop and displays error message 3 times' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).to receive(:puts).with(error_message).thrice
        player.pick_color
      end
    end
  end

  describe '#pick_column' do
    context 'when player picks a valid column number' do
      before do
        valid_num = '5'
        allow(player).to receive(:gets).and_return(valid_num)
        allow(player).to receive(:pick_column_message)
      end

      it 'Does not run loop and returns the valid column number' do
        result = player.pick_column
        expect(result).to eq('5')
      end
    end

    context 'when player picks an invalid column number once, and then a valid one' do
      before do
        invalid_num = '8'
        valid_num = '7'
        allow(player).to receive(:pick_column_message)
        allow(player).to receive(:gets).and_return(invalid_num, valid_num)
      end

      it 'completes the loop and displays error message once' do
        error_message = 'Please pick a valid column number, between 1 and 7'
        expect(player).to receive(:puts).with(error_message).once
        player.pick_column
      end
    end

    context 'when player picks an invalid column number 3 times and then a valid one' do
      before do
        invalid = '0'
        invalid_2 = 'A'
        invalid_3 = '38'
        valid = '3'
        allow(player).to receive(:gets).and_return(invalid, invalid_2, invalid_3, valid)
        allow(player).to receive(:pick_column_message)
      end

      it 'completets loop and displays error message three times' do
        error_message = 'Please pick a valid column number, between 1 and 7'
        expect(player).to receive(:puts).with(error_message).thrice
        player.pick_column
      end
    end
  end
end


