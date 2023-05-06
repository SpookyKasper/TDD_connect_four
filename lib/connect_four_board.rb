
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

  def place_stone(column, stone)
    row_index = find_free_row(column)
    column_index = column - 1
    @board[row_index][column_index] = stone
  end

  def find_free_row_index(column, empty_cell)
    busy_row = column.find_index { |cell| cell != @empty_cell}
    free_row = busy_row.nil? ? column.size - 1 : busy_row - 1
    free_row < 0 ? nil : free_row
  end

  # def find_free_row(column_num)
  #   column = @board.transpose
  #   column = columns[column_num]
  #   free_row = column.find_index { |cell| cell != 'O'}
  #   free_row.nil? ? board.size - 1 : free_row
  # end

  def is_full?
  end
end
