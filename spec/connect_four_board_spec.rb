require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#create_board' do

    before do
      board.create_board
    end

    it 'creates a matrix of 6 rows' do
      expect(board.board.size).to eq(6)
    end

    it 'creates a matrix of 7 columns' do
      expect(board.board[0].size).to eq(7)
    end

    it 'initalize all the positions to nil' do
      expect(board.board.flatten.all?(nil))
    end
  end

  describe '#place_stone' do
    context 'when selected column is 3' do
      context 'when board is empty' do
        before do
          column = 3
          free_row = 5
          allow(board).to receive(:find_free_row).with(column).and_return(free_row)
        end

        it 'places stone in the last row, third column' do
          column = 3
          stone = "\u263A"
          empty_cell = 'O'
          expect{ board.place_stone(column, stone) }.to change { board.board[5][2] }.from(empty_cell).to(stone)
        end
      end
    end
  end
end
