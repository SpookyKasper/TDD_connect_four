require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'

class Connect_Four_Game
  BLACK_SMILEY = "\u263A"
  WHITE_SMILEY = "\u263B"

  def initialize(board, player_1, player_2)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
    @winner = nil
  end

  def play
    set_up_player_names
    set_up_colors
    until game_over?
      @board.display_board
      play_round
    end
    game_over_message
  end

  def play_round

    @player_1.pick_column
  end

  def get_player_name
    loop do
      input = gets.chomp
      verified_input = input if verify_input(input)
      return verified_input if verified_input

      puts 'Please input only letters or numbers'
    end
  end

  def set_up_player_names
    pick_name_message
    @player_1.name = get_player_name
    puts "And what about you player two?"
    @player_2.name = get_player_name
    puts "Cool so #{@player_1.name} and #{@player_2.name}, are you ready for rumble?"
  end

  def set_up_colors
    pick_color_message
    @player_1.color = @player_1.pick_color
    @player_2.color = left_color
    puts "Cool so #{@player_1.name} you'll be playing with the #{@player_1.color} stone"
    puts "Ans #{@player_2.name} you'll be playing with the #{@player_2.color} stone"
    puts "Let's go!"
  end

  def game_over?
    !@winner.nil? || @board.is_full?
  end

  def somebody_won?
    [check_for_winning_row, check_for_winning_column, check_for_winning_diagonal].any?
  end

  def get_winner_name
    stone = check_for_winning_row || check_for_winning_column || check_for_winning_diagonal
    stone == @player_1.color ? @player_1.name : @player_2.name
  end

  def left_color
    @player_1.color == BLACK_SMILEY ? WHITE_SMILEY : BLACK_SMILEY
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

  def count_stones(player)
    @board.board.flatten.count(player.color)
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

  def verify_input(input)
    input.match?(/^[a-zA-Z0-9]+$/)
  end

  def pick_color_message
    puts <<~HEREDOC

        And now dear #{@player_1.name}, which color would you like to pick?

        \e[32m[1]\e[0m Black
        \e[32m[2]\e[0m White

    HEREDOC
  end

  def pick_name_message
    puts <<~HEREDOC

    \e[93mHey there connect four enthusiasts! ready for rumble?
      Please be so kind and agree on who will play first.
      And please type the tame of the first player \e[0m

    HEREDOC
  end

end
