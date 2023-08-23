require_relative '../lib/connect_four_board'
require_relative '../lib/connect_four_player'

class Connect_Four_Game
  GREEN_SMILEY = "\e[32m\u263A\e[0m".freeze
  YELLOW_SMILEY = "\e[33m\u263B\e[0m".freeze

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @winner = nil
  end

  def play
    initial_set_up
    game_loop
    @board.display_board
    game_over_message
  end

  def game_loop
    until game_over?
      @board.display_board
      play_round
    end
  end

  def game_over_message
    if somebody_won?
      winning_stone = check_for_winning_row || check_for_winning_diagonal || check_for_winning_column
      @winner = winning_stone == @player1.color ? @player1.name : @player2.name
      puts
      puts "\e[91mCongratulations #{@winner} you won the game!\e[0m"
    else
      puts "\e[91mBravo people! it is a tie!\e[0m"
    end
  end

  def initial_set_up
    set_up_player_names
    print_names_set_message
    set_up_colors
    print_colors_set_messagge
  end

  def play_round
    player = current_player
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
    input = gets.chomp
    until verify_input(input)
      puts 'Please input only letters or numbers'
      input = gets.chomp
    end
    input
  end

  def set_up_player_names
    ask_player_one_name_message
    @player1.name = get_player_name
    ask_player_two_name_message
    @player2.name = get_player_name
  end

  def set_up_colors
    pick_color_message
    if @player1.pick_color_num == '1'
      @player1.color = GREEN_SMILEY
      @player2.color = YELLOW_SMILEY
    else
      @player1.color = YELLOW_SMILEY
      @player2.color = GREEN_SMILEY
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
    stone == @player1.color ? @player1.name : @player2.name
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

  def current_player
    count_stones(@player1) == count_stones(@player2) ? @player1 : @player2
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

      #{@player1.name}, which color would you like to pick?

      \e[32m[1]\e[0m Green
      \e[32m[2]\e[0m Yellow

    HEREDOC
  end

  def pick_column_message(player)
    puts <<~HEREDOC

      It's now your turn #{player.name}! in which column would you like to play your stone?
      Please pick a column number from 1 to 7

    HEREDOC
  end

  def ask_player_one_name_message
    puts <<~HEREDOC

      Hey there connect four enthusiasts! ready for rumble?
      Please be so kind and agree on who will play first...
      Now please type the name of the first player:

    HEREDOC
  end

  def ask_player_two_name_message
    puts <<~HEREDOC

      And what about you player two?

    HEREDOC
  end

  def print_names_set_message
    puts <<~HEREDOC

      Cool so #{@player1.name} and #{@player2.name} let's get started!

    HEREDOC
  end

  def print_colors_set_messagge
    puts <<~HEREDOC

      Cool so #{@player1.name} you'll be playing with the #{@player1.color} stone
      Ans #{@player2.name} you'll be playing with the #{@player2.color} stone
      Let's go!

    HEREDOC
  end
end
