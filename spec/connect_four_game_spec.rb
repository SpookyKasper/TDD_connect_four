require_relative '../lib/connect_four_game.rb'
require_relative '../lib/connect_four_board.rb'
require_relative '../lib/connect_four_player.rb'

describe Connect_Four_Game do
  let(:board) { instance_double(Board) }
  let(:player_1) { instance_double(Player, name: 'Daniel')}
  subject(:game_win) { described_class.new(board, player_1) }

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
      end
      context 'when board is not full' do
      end
    end
  end
end
