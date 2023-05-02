require '../lib/connect_four_board.rb'

describe Board do
  subject(:board) { described_class.new }.create_board

  describe '#create_board' do
    it 'creates a matrix of 6 rows' do
      expect(board.size).to eq(6)
    end

    it 'creates a matrix of 7 columns' do
      expect(board.size[0]).to eq(7)
    end
  end
end
