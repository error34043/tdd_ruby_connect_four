# frozen_string_literal: true

require './lib/player.rb'
require './lib/board.rb'

describe Player do
  subject(:player) { described_class.new }

  describe '#valid_token' do
    context 'when the token chosen is available' do
      it 'returns true' do
        expect(player.valid_token?(2)).to be true
      end
    end

    context 'when the token chosen is not available' do
      before do
        Player.class_variable_set(:@@taken_tokens, ["\e[33m⬤\e[0m"])
      end

      it 'returns false' do
        expect(player.valid_token?(1)).to be false
      end
    end

    context 'when token chosen is not between 1 and 6' do
      it 'returns nil' do
        expect(player.valid_token?(0)).to be nil
      end

      it 'returns nil' do
        expect(player.valid_token?(7)).to be nil
      end
    end
  end
end
