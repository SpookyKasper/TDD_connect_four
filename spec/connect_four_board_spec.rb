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
        column = ['O', 'O', 'O', 'O', 'O', 'O']
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(5)
      end
    end

    context 'when column has one stone' do
      it 'returns 4' do
        empty_cell = 'O'
        column = ['O', 'O', 'O', 'O', 'O', 'X']
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(4)
      end
    end

    context 'when columns has 3 stones' do
      it 'returns 2' do
        empty_cell = 'O'
        column = ['O', 'O', 'O', 'X', 'X', 'P']
        result = board.find_free_row_index(column, empty_cell)
        expect(result).to eq(2)
      end
    end

    context 'when column is full' do
      it 'returns nil' do
        empty_cell = 'O'
        column = ['X', 'X', 'X', 'X', 'X', 'X']
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

  describe '#get_positive_diagonal' do
    context 'when working on a numbered board' do

      before do
        my_board = [
          [1,   2,  3,  4,  5,  6,  7],
          [8,   9, 10, 11, 12, 13, 14],
          [15, 16, 17, 18, 19, 20, 21],
          [22, 23, 24, 25, 26, 27, 28],
          [29, 30, 31, 32, 33, 34, 35],
          [36, 37, 38, 39, 40, 41, 42]
        ]
        board.instance_variable_set(:@board, my_board)
      end

      context 'when given [0, 0] as a start index' do
        it 'returns [1, 9, 17, 25, 33, 41]' do
          coordinates = [0, 0]
          result = board.get_positive_diagonal(coordinates)
          expectation = [1, 9, 17, 25, 33, 41]
          expect(result).to eq(expectation)
        end
      end

      context 'when given [0, 1] as a start index' do
        it 'returns [2, 10, 18, 26, 34, 42]' do
          coordinates = [0, 1]
          result = board.get_positive_diagonal(coordinates)
          expectation = [2, 10, 18, 26, 34, 42]
          expect(result).to eq(expectation)
        end
      end

      context 'when given [0, 5] as a start index' do
        it 'returns [6, 14]' do
          coordinates = [0, 5]
          result = board.get_positive_diagonal(coordinates)
          expectation = [6, 14]
          expect(result).to eq(expectation)
        end
      end

      context 'when given [1, 0] as a start index' do
        it 'returns [8, 16, 24, 32]' do
          coordinates = [1, 0]
          result = board.get_positive_diagonal(coordinates)
          expectation = [8, 16, 24, 32, 40]
          expect(result).to eq(expectation)
        end
      end
    end
  end

  describe '#get_board_diagonals' do
    context 'when on a connect_four board' do

      before do
        my_board = [
          [1,   2,  3,  4,  5,  6,  7],
          [8,   9, 10, 11, 12, 13, 14],
          [15, 16, 17, 18, 19, 20, 21],
          [22, 23, 24, 25, 26, 27, 28],
          [29, 30, 31, 32, 33, 34, 35],
          [36, 37, 38, 39, 40, 41, 42]
        ]
        board.instance_variable_set(:@board, my_board)
      end

      it 'returns 12 diagonals' do
        diagonals = board.get_board_diagonals
        result = diagonals.size
        expect(result).to eq(12)
      end
    end
  end

  describe '#get_negative_diagonal' do
    context 'when working on a numbered board' do

      before do
        my_board = [
          [1,   2,  3,  4,  5,  6,  7],
          [8,   9, 10, 11, 12, 13, 14],
          [15, 16, 17, 18, 19, 20, 21],
          [22, 23, 24, 25, 26, 27, 28],
          [29, 30, 31, 32, 33, 34, 35],
          [36, 37, 38, 39, 40, 41, 42]
        ]
        board.instance_variable_set(:@board, my_board)
      end

      context 'when given [0, 6] as a start index' do
        it 'returns [7, 13, 19, 25, 31, 37]' do
          coordinates = [0, 6]
          result = board.get_negative_diagonal(coordinates)
          expectation = [7, 13, 19, 25, 31, 37]
          expect(result).to eq(expectation)
        end
      end

      context 'when given [2, 6] as a start index' do
        it 'returns [21, 27, 33, 39]' do
          coordinates = [2, 6]
          result = board.get_negative_diagonal(coordinates)
          expectation = [21, 27, 33, 39]
          expect(result).to eq(expectation)
        end
      end

      context 'when given [0, 4] as a start index' do
        it 'returns [5, 11, 17, 23, 29]' do
          coordinates = [0, 4]
          result = board.get_negative_diagonal(coordinates)
          expectation = [5, 11, 17, 23, 29]
          expect(result).to eq(expectation)
        end
      end
    end
  end

  describe '#is_full?' do
    context 'when board is empty' do

      before do
        board.instance_variable_set(:@board, board.create_board)
        board.instance_variable_set(:@empty_cell, 'O')
      end

      it 'returns false' do
        result = board.is_full?
        expect(result).to eq(false)
      end
    end

    context 'when board is full' do

      before do
        my_board = [
          ['X', 'X', 'X', 'P'],
          ['X', 'X', 'X', 'P'],
          ['X', 'X', 'X', 'P'],
          ['X', 'X', 'X', 'P']
      ]
        board.instance_variable_set(:@board, my_board)
        board.instance_variable_set(:@empty_cell, 'O')
      end

      it 'returns true' do
        result = board.is_full?
        expect(result).to eq(true)
      end
    end

    context 'when board is almost full' do
      before do
        my_board = [
          ['O', 'O', 'X', 'P'],
          ['X', 'X', 'X', 'P'],
          ['X', 'X', 'X', 'P'],
          ['X', 'X', 'X', 'P']
      ]
        board.instance_variable_set(:@board, my_board)
        board.instance_variable_set(:@empty_cell, 'O')
      end

      it 'returns false' do
        result = board.is_full?
        expect(result).to eq(false)
      end
    end
  end
end
