
class Player

  attr_accessor :color, :name

  def initialize(name = 'Player', color = nil)
    @name = name
    @color = color
  end

  def pick_color_num
    input = gets.chomp
    until [1, 2].include?(input.to_i)
      puts 'please type 1 for black or 2 for white'
      input = gets.chomp
    end

    input
  end

  def pick_column_num
    input = gets.chomp
    until (1..7).include?(input.to_i)
      puts 'Please pick a valid column number, between 1 and 7'
      input = gets.chomp
    end

    input
  end
end
