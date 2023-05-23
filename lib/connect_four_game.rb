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
    initial_set_up
    until game_over?
      @board.display_board
      play_round
    end
    @board.display_board
    game_over_message
  end

  def game_over_message
    if somebody_won?
      winning_stone = check_for_winning_row || check_for_winning_diagonal || check_for_winning_column
      @winner = winning_stone == @player_1.color ? @player_1.name : @player_2.name
      puts
      puts "\e[93mCongratulations #{@winner} you won the game!\e[0m"
    else
      puts "\e[93mBravo people! it is a tie![0m"
    end
  end

  def initial_set_up
    set_up_player_names
    print_names_set_message
    set_up_colors
    print_colors_set_messagge
  end

  def play_round
    player = is_playing
    pick_column_message(player)
    column_num = player.pick_column_num.to_i
    until @board.column_is_free?(column_num)
      puts 'please pick a column with available cells'
      column_num = player.pick_column_num.to_i
    end
    stone = player.color
    @board.place_stone(column_num, stone)
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
    ask_player_one_name_message
    @player_1.name = get_player_name
    ask_player_two_name_message
    @player_2.name = get_player_name
  end

  def set_up_colors
    pick_color_message
    if @player_1.pick_color_num == '1'
      @player_1.color = BLACK_SMILEY
      @player_2.color = WHITE_SMILEY
    else
      @player_1.color = WHITE_SMILEY
      @player_2.color = BLACK_SMILEY
    end
  end

  def game_over?
    somebody_won? || @board.is_full?
  end

  def somebody_won?
    [check_for_winning_row, check_for_winning_column, check_for_winning_diagonal].any?
  end

  def get_winner_name
    stone = check_for_winning_row || check_for_winning_column || check_for_winning_diagonal
    stone == @player_1.color ? @player_1.name : @player_2.name
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

  def is_playing
    count_stones(@player_1) == count_stones(@player_2) ? @player_1 : @player_2
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

        \e[93m#{@player_1.name}, which color would you like to pick\e[0m?

        \e[32m[1]\e[0m Black
        \e[32m[2]\e[0m White

    HEREDOC
  end

  def pick_column_message(player)
    puts <<~HEREDOC

      \e[93mIt's now your turn #{player.name}! in which column would you like to play your stone?
      Please pick a column number from 1 to 7\e[0m

    HEREDOC
  end

  def ask_player_one_name_message
    puts <<~HEREDOC

    \e[93mHey there connect four enthusiasts! ready for rumble?
    Please be so kind and agree on who will play first...
    Now please type the name of the first player \e[0m

    HEREDOC
  end

  def ask_player_two_name_message
    puts <<~HEREDOC

    \e[93mAnd what about you player two?\e[0m

    HEREDOC
  end

  def print_names_set_message
    puts <<~HEREDOC

    \e[93mCool so #{@player_1.name} and #{@player_2.name} let's get started!\e[0m

    HEREDOC
  end

  def print_colors_set_messagge
    puts <<~HEREDOC

    \e[93mCool so #{@player_1.name} you'll be playing with the #{@player_1.color} stone
    Ans #{@player_2.name} you'll be playing with the #{@player_2.color} stone
    Let's go!\e[0m

    HEREDOC
  end
end
