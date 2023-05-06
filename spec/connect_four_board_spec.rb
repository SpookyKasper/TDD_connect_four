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
        stone = "\u263A"
        empty_cell = 'O'
        column = Array.new(6, empty_cell)
        column[5] = stone
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(4)
      end
    end

    context 'when columns has 3 stones' do
      it 'returns 2' do
        stone = "\u263A"
        empty_cell = 'O'
        column = [empty_cell, empty_cell, empty_cell, stone, stone, stone]
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(2)
      end
    end

    context 'when column is full' do
      it 'returns nil' do
        stone = "\u263A"
        empty_cell = 'O'
        column = Array.new(6, stone)
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(nil)
      end
    end
  end

  describe '#place_stone' do
    before do
      board.instance_variable_set(:@board, board.create_board)
    end

    context 'when picked column is empty' do
      it 'changes last row value to stone value' do
        column_num = 3
        stone = "\u263A"
        empty_cell = board.instance_variable_get(:@empty_cell)
        expect { board.place_stone(column_num, stone) }.to change { board.board[5][2] }.from(empty_cell).to(stone)
      end
    end

    context 'when column as 2 stones' do
      before do
        allow(board).to receive(:find_free_row_index).and_return(3)
      end

      it 'changes the first free row to stone value' do
        column_num = 3
        stone = "\u263A"
        empty_cell = board.instance_variable_get(:@empty_cell)
        expect { board.place_stone(column_num, stone) }.to change { board.board[3][2] }.from(empty_cell).to(stone)
      end
    end

    context 'when column is full' do
      before do
        allow(board).to receive(:find_free_row_index).and_return(nil)
      end

      it 'raises a Type error' do
        column_num = 3
        stone = "\u263A"
        empty_cell = board.instance_variable_get(:@empty_cell)
        expect { board.place_stone(column_num, stone) }.to raise_error(TypeError)
      end
    end
  end
end
