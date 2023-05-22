require_relative '../lib/connect_four_game.rb'
require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'
require 'matrix'

describe Connect_Four_Game do
  let(:board) { instance_double(Board, empty_cell: 'O') }
  let(:player_1) { instance_double(Player, name: 'Daniel', color: "\u263A")}
  let(:player_2) { instance_double(Player, name: 'Ivan', color: "\u263B")}
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
        before do
          allow(board).to receive(:get_board_diagonals).and_return(
            [['O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O']]
          )
        end

        it 'returns nil' do
          result = game.check_for_winning_diagonal
          expect(result).to be_nil
        end
      end

      context 'when there is a winning diagonal' do
        before do
          allow(board).to receive(:get_board_diagonals).and_return(
            [['O', 'O', 'O', 'P' 'O'],
            ['X', 'X', 'X', 'X', 'O']])
        end

        it 'returns winning stone' do
          result = game.check_for_winning_diagonal
          expect(result).to eq('X')
        end
      end
    end
  end

  describe '#somebody_won?' do
    context 'when there is a winning diagonal' do
      before do
        stone = "\u263A"
        allow(game).to receive(:check_for_winning_diagonal).and_return(stone)
        allow(game).to receive(:check_for_winning_row).and_return(nil)
        allow(game).to receive(:check_for_winning_column).and_return(nil)
      end

      it 'returns true' do
        result = game.somebody_won?
        expect(result).to be(true)
      end
    end

    context 'when there is a winning row' do
      before do
        stone = "\u263A"
        allow(game).to receive(:check_for_winning_diagonal).and_return(nil)
        allow(game).to receive(:check_for_winning_row).and_return(stone)
        allow(game).to receive(:check_for_winning_column).and_return(nil)
      end

      it 'returns true' do
        result = game.somebody_won?
        expect(result).to be(true)
      end
    end

    context 'when there is a winning column' do
      before do
        stone = "\u263A"
        allow(game).to receive(:check_for_winning_diagonal).and_return(nil)
        allow(game).to receive(:check_for_winning_row).and_return(nil)
        allow(game).to receive(:check_for_winning_column).and_return(stone)
      end

      it 'returns true' do
        result = game.somebody_won?
        expect(result).to be(true)
      end
    end

    context 'when nobody won' do
      before do
        allow(game).to receive(:check_for_winning_diagonal).and_return(nil)
        allow(game).to receive(:check_for_winning_row).and_return(nil)
        allow(game).to receive(:check_for_winning_column).and_return(nil)
      end

      it 'returns false' do
        result = game.somebody_won?
        expect(result).to be(false)
      end
    end
  end

  describe '#get_winner_name' do
    context 'when player 1 won' do
      before do
        player_1_stone = "\u263A"
        allow(game).to receive(:check_for_winning_diagonal).and_return(player_1_stone)
        allow(game).to receive(:check_for_winning_row).and_return(nil)
        allow(game).to receive(:check_for_winning_column).and_return(nil)
      end

      it 'it returns player 1 name' do
        result = game.get_winner_name
        expect(result).to eq(player_1.name)
      end
    end

    before do
      player_2_stone = "\u263B"
      allow(game).to receive(:check_for_winning_diagonal).and_return(player_2_stone)
      allow(game).to receive(:check_for_winning_row).and_return(nil)
      allow(game).to receive(:check_for_winning_column).and_return(nil)
    end

    context 'when player 2 won' do
      it 'it returns player 2 name' do
        result = game.get_winner_name
        expect(result).to eq(player_2.name)
      end
    end
  end

  describe '#left_color' do
    context 'when player_1 picks black smiley' do
      let(:player_1) { instance_double(Player, name: 'Daniel', color: "\u263A") }
      let(:player_2) { instance_double(Player, name: 'Ivan', color: nil) }

      it 'returns white smiley' do
        white_smiley = "\u263B"
        result = game.left_color
        expect(result).to eq(white_smiley)
      end
    end

    context 'when player_2 picks whites smilye' do
      let(:player_1) { instance_double(Player, name: 'Daniel', color: "\u263B") }
      let(:player_2) { instance_double(Player, name: 'Ivan') }

      it 'returns black smiley' do
        black_smiley_unicode = "\u263A"
        result = game.left_color
        expect(result).to eq(black_smiley_unicode)
      end
    end
  end

  describe '#get_player_name' do
    context 'when player inputs a valid name' do
      before do
        valid_name = 'Daniel'
        allow(game).to receive(:gets).and_return(valid_name)
        allow(game).to receive(:verify_input).with(valid_name).and_return(true)
      end

      it 'returns the name' do
        result = game.get_player_name
        expect(result).to eq('Daniel')
      end

      it 'completes loop without displaying error message' do
        error_message = 'Please input only letters or numbers'
        expect(game).not_to receive(:puts).with(error_message)
        game.get_player_name
      end
    end

    context 'when player inputs a invalid and then a valid name' do
      before do
        invalid_name = '#=1daniel'
        valid_name = 'daniel'
        allow(game).to receive(:gets).and_return(invalid_name, valid_name)
      end

      it 'completes the loop and display error message once' do
        error_message = 'Please input only letters or numbers'
        expect(game).to receive(:puts).with(error_message).once
        game.get_player_name
      end
    end
  end

  describe '#is_playing' do
  end

  describe '#count_stones' do
    let(:board) { instance_double(Board, empty_cell: 'O') }
    let(:player_1) { instance_double(Player, name: 'Daniel', color: "X")}
    let(:player_2) { instance_double(Player, name: 'Ivan', color: "M")}
    subject(:game) { described_class.new(board, player_1, player_2) }

    context 'when the player did no play yet' do
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
      it 'returns 0' do
        result = game.count_stones(player_1)
        expect(result).to eq(0)
      end
    end
    context 'when the player played 3 times' do
      before do
        allow(board).to receive(:board).and_return(
          [['O', 'O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'X', 'O'],
          ['O', 'O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'X', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'X', 'O', 'O', 'O']]
        )
      end
      it 'returns 3' do
        result = game.count_stones(player_1)
        expect(result).to eq(3)
      end
    end
  end
end
