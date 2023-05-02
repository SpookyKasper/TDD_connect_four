require_relative '../lib/connect_four_board.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#create_board' do

    before do
      board.create_board
    end

    it 'creates a matrix of 6 rows' do
      expect(board.board.size).to eq(6)
    end

    it 'creates a matrix of 7 columns' do
      expect(board.board[0].size).to eq(7)
    end

    it 'initalize all the positions to nil' do
      expect(board.board.flatten.all?(nil))
    end
  end
end
