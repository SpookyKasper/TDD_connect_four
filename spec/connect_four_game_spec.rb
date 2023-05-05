require_relative '../lib/connect_four_game.rb'
require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'

describe Connect_Four_Game do
  let(:board) { instance_double(Board) }
  let(:player_1) { instance_double(Player, name: 'Daniel')}
  let(:player_2) { instance_double(Player, name: 'Ivan')}
  subject(:game_win) { described_class.new(board, player_1, player_2) }

  describe '#game_over?' do
    context 'when some player won' do
      context 'when board is full' do

        before do
          game_win.instance_variable_set(:@winner, player_1)
          allow(board).to receive(:is_full?).and_return(true)
        end

        it 'returns true' do
          result = game_win.game_over?
          expect(result).to be(true)
        end
      end

      context 'when board is not full' do

        before do
          game_win.instance_variable_set(:@winner, player_1)
          allow(board).to receive(:is_full?).and_return(false)
        end

        it 'returns true' do
          result = game_win.game_over?
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
          result = game_win.game_over?
          expect(result).to be(true)
        end
      end

      context 'when board is not full' do

        before do
          allow(board).to receive(:is_full?).and_return(false)
        end

        it 'returns false' do
          result = game_win.game_over?
          expect(result).to be(false)
        end
      end
    end
  end

  describe '#check_for_winning_row' do
    context 'when some player won' do

      it 'changes @winner from nil to winning player' do
        winner = game_win.instance_variable_get(:@winner)
        expect{ game_win.check_for_winning_row }.to change { winner }.from(nil).to(player_1)
      end
    end
  end
end
