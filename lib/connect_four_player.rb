
class Player
  BLACK_SMILEY = "\u263A"
  WHITE_SMILEY = "\u263B"

  attr_reader :name

  def initalize(name)
    @name = name
    @color = nil
  end

  def pick_color
    pick_color_message
    input = gets.chomp
    until [1, 2].include?(input.to_i)
      puts 'please type 1 for black or 2 for white'
      input = gets.chomp
    end

    @color = input == '1' ? BLACK_SMILEY : WHITE_SMILEY
  end

  def pick_column
    pick_column_message
    input = gets.chomp
    until (1..7).include?(input.to_i)
      puts 'Please pick a valid column number, between 1 and 7'
      input = gets.chomp
    end

    input
  end

  def pick_column_message
    puts <<~HEREDOC

      \e[93mSo #{self.name} in whic column do you want to play your stone?
      Please pick a column number from 1 to 7\e[0m
    HEREDOC
  end

  def pick_color_message
    puts <<~HEREDOC

      \e[93mHey there connect four enthusiasts! ready for rumble?
      Please be so kind and agree on who will play first.\e[0m

        And now dear player_1, which color would you like to pick?

        \e[32m[1]\e[0m Black
        \e[32m[2]\e[0m White

    HEREDOC
  end
end
