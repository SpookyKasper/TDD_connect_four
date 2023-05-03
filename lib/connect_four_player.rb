


class Player
  BLACK_SMILEY = "\u263A"
  WHITE_SMILEY = "\u263B"

  def initalize
    @color = nil
  end

  def pick_color
    print_pick_color_message
    input = gets.chomp
    until [1, 2].include?(input.to_i)
      puts 'please type 1 for black or 2 for white'
      input = gets.chomp
    end

    @color = input == '1' ? BLACK_SMILEY : WHITE_SMILEY
  end

  def print_pick_color_message
    puts <<~HEREDOC

      \e[93mHey there connect four enthusiasts! ready for rumble?
      Please be so kind and agree on who will play first.\e[0m

        And now dear player_1, which color would you like to pick?

        \e[32m[1]\e[0m Black
        \e[32m[2]\e[0m White

    HEREDOC
  end
end
