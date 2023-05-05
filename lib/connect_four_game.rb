
require_relative '../lib/connect_four_board.rb'

class Connect_Four_Game
  def initialize(board, player_1, player_2)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
    @winner = nil
  end

  def game_over?
    !@winner.nil? || @board.is_full?
  end

  def check_for_winning_row
  end
end
