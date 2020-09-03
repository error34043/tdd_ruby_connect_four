# frozen_string_literal: true

require './lib/player.rb'
require './lib/board.rb'

describe Player do
  subject(:player) { described_class.new }

  describe '#fix_winner' do
    context 'a player is assigned the winner role' do
      it 'changes the win property of the player to true' do
        player.fix_winner
        expect(player.win).to be true
      end
    end
  end
end
