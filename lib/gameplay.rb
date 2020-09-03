# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'instructions.rb'

class GamePlay < Board
  include Instructions

  attr_accessor :players
  
  @active_player = ''
  @game_complete = false
  @game_won = false


  def game
    play_time = true
    start_new_game
    loop do
      single_round
      play_time = replay?
      break if play_time == false
      @game_board = Board.new
      @players.each { |player| player.win = false }
      system 'clear'
    end
    puts leave_message
  end

  def initialize
    @game_board = Board.new
    @players = []
  end

  private

  def add_player(player_number)
    new_player = Player.new
    new_player.input_name_of_player(player_number)
    new_player.input_token
    @players << new_player
  end

  def start_new_game
    puts logo
    puts introduction
    add_player(1)
    add_player(2)
    system 'clear'
  end

  def turn
    @game_board.display
    puts "\n#{@active_player.name}".magenta + ", your turn! Pick a column to drop your token into.".teal
    loop do
      print '[column]: '
      move = gets.chomp.to_i
      complete_move = @game_board.add_move_to_board(move, @active_player.token)
      break if complete_move == true
      puts "\nThat doesn't seem quite right. Please pick a column on the board that has space for your token.".red
    end
    system 'clear'
  end

  def switch_active_player
    if @active_player == @players[0]
      @active_player = @players[1]
    else
      @active_player = @players[0]
    end
  end

  def win
    @winner = @players.find { |player| player.win == true }
    @loser = @players.find { |player| player.win == false }
    @game_board.display
    puts win_message(@winner.name, @loser.name)
  end

  def tie
    @game_board.display
    puts tie_message(@players[0].name, @players[1].name)
  end

  def game_over
    if @game_board.victory?
      @active_player.fix_winner
      @game_complete = true
      @game_won = true
      return true
    elsif @game_board.filled_up?
      @game_complete = true
      @game_won = false
      return true
    end
    false
  end

  def single_round
    @active_player = @players[1]
    loop do
      if game_over
        @game_won ? win : tie
        break
      end
      switch_active_player
      turn
    end
  end

  def valid_replay_response?(response)
    response.downcase == 'y' || response.downcase == 'yes' || response.downcase == 'n' || response.downcase == 'no'
  end

  def replay?
    puts "\nWould you both like to play again?".teal
    keep_playing = ''
    loop do
      print '[yes/no]: '
      keep_playing = gets.chomp
      break if valid_replay_response?(keep_playing)
      puts "\nI'm sorry, I don't understand. Please say either yes or no.".red
    end
    (keep_playing.downcase == 'y' || keep_playing.downcase == 'yes') ? true : false
  end
end

# test = GamePlay.new
# test.game
