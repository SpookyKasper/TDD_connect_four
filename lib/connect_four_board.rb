
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(6, Array.new(7, nil))
  end
end
