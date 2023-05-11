
class Board
  attr_reader :board, :empty_cell

  def initialize
    @board = create_board
    @empty_cell = 'O'
  end

  def create_board
    Array.new(6) { Array.new(7, @empty_cell) }
  end

  def display_board
    @board.each do |row|
      puts row.join(' | ')
    end
  end

  def place_stone(column_num, stone)
    column = @board.transpose[column_num]
    row_index = find_free_row_index(column, @empty_cell)
    column_index = column_num - 1
    @board[row_index][column_index] = stone
  end

  def find_free_row_index(column, empty_cell)
    busy_row = column.find_index { |cell| cell != @empty_cell}
    free_row = busy_row.nil? ? column.size - 1 : busy_row - 1
    free_row < 0 ? nil : free_row
  end

  def get_positive_diagonal(start_coordinates)
    diagonal = []
    start_row, start_column = start_coordinates
    diagonal_size = @board.size - start_row
    diagonal_size.times do
      cell = @board[start_row][start_column]
      diagonal << cell unless cell.nil?
      start_row += 1
      start_column += 1
    end
    diagonal
  end

  def get_negative_diagonal(coordinates)
    diagonal = []
    row, column = coordinates
    diagonal_size = @board.size - row
    diagonal_size.times do
      cell = @board[row][column]
      diagonal << cell unless cell.nil?
      row += 1
      column -= 1
      break if row < 0 || column < 0
    end
    diagonal
  end

  def get_board_diagonals
    diagonals = []
    4.times do |time|
      diagonals << get_positive_diagonal([0, time])
      diagonals << get_negative_diagonal([0, time + 3])
    end
    3.times do |time|
      diagonals << get_positive_diagonal([time, 0])
      diagonals << get_negative_diagonal([time, 6])
    end
    diagonals.uniq
  end

  def is_full?
    @board.flatten.none? { |el| el == @empty_cell}
  end
end
