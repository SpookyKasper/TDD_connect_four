
require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'
require 'matrix'

class Connect_Four_Game
  def initialize(board, player_1, player_2)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
    @winner = nil
  end

  def play
    introduction
  end

  def introduction
    pick_color
  end

  def game_over?
    !@winner.nil? || @board.is_full?
  end


  def four_consecutives(array)
    consecutives = 1
    empty_cell = @board.empty_cell
    stone = nil
    array.each_with_index do |value, index|
      next if index - 1 < 0 || value == empty_cell

      stone = value
      value == array[index - 1] ? consecutives += 1 : consecutives = 1
      break if consecutives >= 4
    end
    consecutives >= 4 ? stone : nil
  end



  def check_for_winning_row
    stone = nil
    rows = @board.board
    rows.each do |row|
      stone = four_consecutives(row)

      break if stone
    end
    stone
  end

  def check_for_winning_column
    stone = nil
    columns = @board.board.transpose
    columns.each do |row|
      stone = four_consecutives(row)

      break if stone
    end
    stone
  end

  def check_for_winning_diagonal
    stone = nil
    diagonals = @board.get_board_diagonals
    diagonals.each do |diagonal|
      stone = four_consecutives(diagonal)

      break if stone
    end
    stone
  end

  def somebody_won?
    [check_for_winning_row, check_for_winning_column, check_for_winning_diagonal].any?
  end

  def get_winner_name
    stone = check_for_winning_row || check_for_winning_column || check_for_winning_diagonal
    stone == @player_1.color ? @player_1.name : @player_2.name
  end
end
