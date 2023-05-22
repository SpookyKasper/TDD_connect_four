require_relative '../lib/connect_four_player.rb'

describe Player do
  subject(:player) { described_class.new }

  describe '#pick_color_num' do
    context 'when player inputs a valid input' do

      before do
        valid_input = '1'
        allow(player).to receive(:gets).and_return(valid_input)
      end

      it 'completes loop and does not display error message' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).not_to receive(:puts).with(error_message)
        player.pick_color_num
      end
    end

    context 'when player inputs a invalid input and then a valid input' do

      before do
        invalid_input = '3'
        valid_input = '2'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'sets player color to white smilye unicode value' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).to receive(:puts).with(error_message).once
        player.pick_color_num
      end
    end

    context 'when player types 3 invalid inputs and then a valid input' do

      before do
        invalid_input = 'A'
        invalid_input_2 = '0'
        invalid_input_3 = ''
        valid_input = '1'
        allow(player).to receive(:gets).and_return(invalid_input, invalid_input_2, invalid_input_3, valid_input)
      end

      it 'completes loop and displays error message 3 times' do
        error_message = 'please type 1 for black or 2 for white'
        expect(player).to receive(:puts).with(error_message).thrice
        player.pick_color_num
      end
    end
  end

  describe '#pick_column_num' do

    context 'when player picks an invalid column number once, and then a valid one' do
      before do
        invalid_num = '8'
        valid_num = '7'
        allow(player).to receive(:gets).and_return(invalid_num, valid_num)
      end

      it 'completes the loop and displays error message once' do
        error_message = 'Please pick a valid column number, between 1 and 7'
        expect(player).to receive(:puts).with(error_message).once
        player.pick_column_num
      end
    end

    context 'when player picks an invalid column number 3 times and then a valid one' do
      before do
        invalid = '0'
        invalid_2 = 'A'
        invalid_3 = '38'
        valid = '3'
        allow(player).to receive(:gets).and_return(invalid, invalid_2, invalid_3, valid)
      end

      it 'completets loop and displays error message three times' do
        error_message = 'Please pick a valid column number, between 1 and 7'
        expect(player).to receive(:puts).with(error_message).thrice
        player.pick_column_num
      end
    end
  end
end


