require_relative '../lib/connect_four_game.rb'
require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'
require 'matrix'

describe Connect_Four_Game do
  let(:board) { instance_double(Board, empty_cell: 'O') }
  let(:player_1) { instance_double(Player, name: 'Daniel')}
  let(:player_2) { instance_double(Player, name: 'Ivan')}
  subject(:game) { described_class.new(board, player_1, player_2) }

  describe '#game_over?' do
    context 'when some player won' do
      context 'when board is full' do

        before do
          game.instance_variable_set(:@winner, player_1)
          allow(board).to receive(:is_full?).and_return(true)
        end

        it 'returns true' do
          result = game.game_over?
          expect(result).to be(true)
        end
      end

      context 'when board is not full' do

        before do
          game.instance_variable_set(:@winner, player_1)
          allow(board).to receive(:is_full?).and_return(false)
        end

        it 'returns true' do
          result = game.game_over?
          expect(result).to be(true)
        end
      end
    end

    context 'when no player won' do
      context 'when board is full' do

        before do
          allow(board).to receive(:is_full?).and_return(true)
        end

        it 'returns true' do
          result = game.game_over?
          expect(result).to be(true)
        end
      end

      context 'when board is not full' do

        before do
          allow(board).to receive(:is_full?).and_return(false)
        end

        it 'returns false' do
          result = game.game_over?
          expect(result).to be(false)
        end
      end
    end
  end

  describe '#four_consecutives' do

    context 'when there are 4 consecutives values that are not empty cells' do
      context 'when they are in the middle of the array' do
        it 'returns the value' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [empty_cell, empty_cell, stone, stone, stone, stone, empty_cell]
          result = game.four_consecutives(array)
          expect(result).to eq(stone)
        end
      end

      context 'when they are at the beigning of the array' do
        it 'returns the value' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [stone, stone, stone, stone, stone, empty_cell, empty_cell]
          result = game.four_consecutives(array)
          expect(result).to eq(stone)
        end
      end

      context 'when they are at the end of the array' do
        it 'returns the value' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [empty_cell, empty_cell, stone, stone, stone, stone]
          result = game.four_consecutives(array)
          expect(result).to eq(stone)
        end
      end

      context 'when the array has only 4 values' do
        it 'returns the value' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [stone, stone, stone, stone]
          result = game.four_consecutives(array)
          expect(result).to eq(stone)
        end
      end
    end

    context 'when there are not 4 consecutives' do
      context 'when array has only empty cells' do
        it 'returns nil' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell]
          result = game.four_consecutives(array)
          expect(result).to be_nil
        end
      end

      context 'when array has 3 consecutives' do
        it 'returns nil' do
          stone = "\u263A"
          empty_cell = 'O'
          array = [stone, stone, stone, empty_cell, stone, empty_cell]
          result = game.four_consecutives(array)
          expect(result).to be_nil
        end
      end
    end
  end

  describe '#check_for_winning_row' do
    context 'when board has no winning row' do
      context 'when board is empty' do

        before do
          allow(board).to receive(:board).and_return(
            [['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O']]
          )
        end

        it 'returns nil' do
          result = game.check_for_winning_row
          expect(result).to be_nil
        end
      end

      context 'when board has values' do

        before do
          allow(board).to receive(:board).and_return(
            [['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['X', 'P', 'X', 'P', 'X', 'O'],
            ['X', 'X', 'X', 'P', 'X', 'P']]
          )
        end

        it 'returns nil' do
          result = game.check_for_winning_row
          expect(result).to be_nil
        end
      end

      context 'when board is full' do

        before do
          allow(board).to receive(:board).and_return(
            [['P', 'X', 'P', 'X', 'X', 'P'],
            ['X', 'X', 'P', 'X', 'X', 'P'],
            ['P', 'P', 'P', 'X', 'X', 'P'],
            ['P', 'X', 'X', 'P', 'P', 'X'],
            ['P', 'X', 'P', 'X', 'X', 'P'],
            ['X', 'P', 'X', 'P', 'P', 'X']]
          )
        end

        it 'returns nil' do
          result = game.check_for_winning_row
          expect(result).to be_nil
        end
      end
    end

    context 'when board has a winning row' do
      context 'when in the last row' do

        before do
          allow(board).to receive(:board).and_return(
            [['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'X', 'X', 'X', 'X', 'O']]
          )
        end

        it 'returns winning stone' do
          winning_stone = "X"
          result = game.check_for_winning_row
          expect(result).to eq(winning_stone)
        end
      end

      context 'when in a middle row' do
        before do
          allow(board).to receive(:board).and_return(
            [['O', 'O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'X', 'X', 'X', 'X', 'O'],
            ['O', 'P', 'X', 'P', 'P', 'P', 'O'],
            ['P', 'P', 'P', 'X', 'P', 'X', 'O']]
          )
        end

        it 'returns winning stone' do
          winning_stone = "X"
          result = game.check_for_winning_row
          expect(result).to eq(winning_stone)
        end
      end

      context 'when in the top row' do
        before do
          allow(board).to receive(:board).and_return(
            [['O', 'X', 'P', 'P', 'P', 'P', 'O'],
            ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'P', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'X', 'P', 'X', 'X', 'O'],
            ['O', 'P', 'X', 'P', 'P', 'P', 'O'],
            ['P', 'P', 'P', 'X', 'P', 'X', 'O']]
          )
        end

        it 'returns winning stone' do
          winning_stone = "P"
          result = game.check_for_winning_row
          expect(result).to eq(winning_stone)
        end
      end
    end

    describe '#check_for_winning_column' do
      context 'when there is no winning column' do
        context 'when board is empty' do

          before do
            allow(board).to receive(:board).and_return(
              [['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O']]
            )
          end

          it 'returns nil' do
            result = game.check_for_winning_column
            expect(result).to be_nil
          end
        end

        context 'when board is partially fill' do

          before do
            allow(board).to receive(:board).and_return(
              [['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'X', 'O', 'O', 'O', 'O'],
              ['X', 'P', 'X', 'O', 'O', 'O'],
              ['P', 'P', 'P', 'X', 'O', 'O'],
              ['P', 'P', 'P', 'X', 'P', 'X']]
            )
          end

          it 'returns nil' do
            result = game.check_for_winning_column
            expect(result).to be_nil
          end
        end

        context 'when board is full' do

          before do
            allow(board).to receive(:board).and_return(
              [['P', 'X', 'P', 'X', 'X', 'P'],
              ['X', 'X', 'P', 'X', 'X', 'P'],
              ['P', 'P', 'P', 'X', 'X', 'P'],
              ['P', 'X', 'X', 'P', 'P', 'X'],
              ['P', 'X', 'P', 'X', 'X', 'P'],
              ['X', 'P', 'X', 'P', 'P', 'X']]
            )
          end

          it 'returns nil' do
            result = game.check_for_winning_column
            expect(result).to be_nil
          end
        end
      end

      context 'when there is a winning column' do
        context 'when board is partially fill' do

          before do
            allow(board).to receive(:board).and_return(
              [['O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O'],
              ['X', 'O', 'O', 'O', 'O', 'O'],
              ['X', 'O', 'O', 'O', 'O', 'O'],
              ['X', 'P', 'P', 'O', 'O', 'O'],
              ['X', 'P', 'P', 'O', 'O', 'O']]
            )
          end

          it 'returns winning stone X' do
            result = game.check_for_winning_column
            expect(result).to eq('X')
          end
        end

        context 'when board is full' do
          before do
            allow(board).to receive(:board).and_return(
              [['X', 'X', 'P', 'X', 'P', 'X', 'X'],
              ['P', 'P', 'P', 'X', 'P', 'X', 'P'],
              ['P', 'X', 'X', 'X', 'P', 'X', 'P'],
              ['P', 'P', 'P', 'X', 'X', 'P', 'P'],
              ['X', 'P', 'X', 'P', 'P', 'X', 'X'],
              ['P', 'X', 'P', 'X', 'P', 'X', 'P']]
            )
          end
          it 'returns winning stone X' do
            result = game.check_for_winning_column
            expect(result).to eq('X')
          end
        end
      end
    end

    describe '#check_for_winning_diagonal' do
      context 'when there is no winning diagonal' do
        context 'when board is empty' do

          before do
            allow(board).to receive(:board).and_return(Array.new(6) { Array.new(7, 'O')})
          end

          it 'returns nil' do
            result = game.check_for_winning_diagonal
            expect(result).to be_nil
          end
        end
        context 'when board is partially filled' do
        end
        context 'when board is full' do
        end
      end

      context 'when there is a winning diagonal' do
        context 'when in the middle of the board' do
          before do
            allow(board).to receive(:board).and_return([
              ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'X', 'O', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'X', 'O', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'X', 'O', 'O', 'O'],
              ['O', 'O', 'O', 'O', 'X', 'O', 'O'],
            ])
          end

          it 'returns winning stone' do
            result = game.check_for_winning_diagonal
            expect(result).to eq('X')
          end
        end

        context 'when in a side when board is full' do
        end
      end
    end
  end

  #   context 'when board has a winning row in the last row' do
  #     let(:board) { instance_double(Board) }
  #     let(:player_1) { instance_double(Player) }
  #     let(:player_2) { instance_double(Player) }
  #     let(:game) { described_class.new(board, player_1, player_2)}

  #     before do
  #       allow(player_1).to receive(:color).and_return("\u263A")
  #     end

  #     it 'returns winning stone' do
  #       result = game.check_for_winning_row
  #       stone = player_1.color
  #       expect(result).to eq(stone)
  #     end
  #   end
  # end
  # describe '#play_move' do
  #   let(:board) { instance_double(Board) }
  #   let(:player_1) { instance_double(Player, name: 'Daniel') }
  #   let(:player_2) { instance_double(Player, name: 'Ivan') }
  #   subject(:game) { described_class.new(board, player_1, player_2) }

  #   context 'when player 1 plays a stone in column 3 and column is empty' do

  #     before do
  #       stone = "\u263A"
  #       player_1.instance_variable_set(:@color, stone)
  #       allow(board).to receive(:board).and_return(Array.new(6) { Array.new(7, 'O')})
  #       allow(player_1).to receive(:color).and_return(stone)
  #       allow(board).to receive(:place_stone).and change { }
  #     end

  #     it 'changes the last row of the board from an empty cell to the player color' do
  #       column = 7
  #       empty_cell = 'O'
  #       player_1_color = player_1.instance_variable_get(:@color)
  #       expect { game.play_move(player_1, column) }.to change { board.board[5][6] }.from(empty_cell).to(player_1_color)
  #     end
  #   end
  # end
end
