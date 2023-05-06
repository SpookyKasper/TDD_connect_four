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

  describe '#find_free_row_index' do
    context 'when column is empty' do
      it 'returns 5' do
        empty_cell = 'O'
        column = Array.new(6, empty_cell)
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(5)
      end
    end

    context 'when column has one stone' do
      it 'returns 4' do
        stone = '\u263A'
        empty_cell = 'O'
        column = Array.new(6, empty_cell)
        column[5] = stone
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(4)
      end
    end

    context 'when columns has 3 stones' do
      it 'returns 2' do
        stone = '\u263A'
        empty_cell = 'O'
        column = [empty_cell, empty_cell, empty_cell, stone, stone, stone]
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(2)
      end
    end

    context 'when column is full' do
      it 'returns nil' do
        stone = '\u263A'
        empty_cell = 'O'
        column = Array.new(6, stone)
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(nil)
      end
    end
  end

  describe '#find_free_row' do
    context 'when column is 4 and there is no stone in the column' do
      it 'returns 5' do
        column = 4
        result = board.find_free_row(column)
        expect(result).to eq(5)
      end
    end

    context 'when column is 4 and there is 2 stones in the 4th column' do
      before do
        stone = "\u263A"
        board.board[5][3] = stone
        board.board[4][3] = stone
      end
      it 'returns 3' do
        column = 4
        result = board.find_free_row(column)
        expect(result).to eq(3)
      end
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
