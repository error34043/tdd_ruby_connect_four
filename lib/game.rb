# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
class Game
  attr_accessor :players
  
  def initialize
    @players = []
  end

  def add_player
    new_player = Player.new
    new_player.input_name
    @players << new_player
  end
end
