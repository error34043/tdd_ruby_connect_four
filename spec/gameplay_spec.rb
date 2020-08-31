# frozen_string_literal: true

require './lib/player.rb'
require './lib/board.rb'
require './lib/gameplay.rb'

describe GamePlay do
  subject(:gameplay) { described_class.new }

  describe '#add_player' do
    context 'when a single player is added' do
      before do
        allow(gameplay).to receive(:gets).and_return("Test\n", "1\n")
      end

      it 'adds the player to the @players array' do
        test_array = gameplay.instance_variable_get(:players)
        expect(test_array[0].name).to eql('Test')
        expect(test_array[0].token).to eql("\u2b24".yellow)
      end
    end
  end
end
