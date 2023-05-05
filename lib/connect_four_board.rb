
class Board
  attr_reader :board

  def initialize
    @board = create_board
    @winner = nil
  end

  def create_board
    Array.new(6, Array.new(7, 'O'))
  end

  def display_board
    @board.each do |row|
      puts row.join(' | ')
    end
  end

  def game_over?
    @winner || is_full?
  end

  def is_full?
  end
end

board = Board.new
board.display_board
