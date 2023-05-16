
class Player
  BLACK_SMILEY = "\u263A"
  WHITE_SMILEY = "\u263B"

  attr_reader :name
  attr_accessor :color

  def initialize(name = 'Player', color = nil)
    @name = name
    @color = color
  end

  def pick_color
    input = gets.chomp
    until [1, 2].include?(input.to_i)
      puts 'please type 1 for black or 2 for white'
      input = gets.chomp
    end

    input == '1' ? BLACK_SMILEY : WHITE_SMILEY
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
end
