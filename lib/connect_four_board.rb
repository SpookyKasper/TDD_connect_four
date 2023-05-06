
class Board
  attr_reader :board

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

  def is_full?
  end
end
