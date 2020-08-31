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

  def initialize
    @game_board = Board.new
    @players = []
  end

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
    @active_player = @players[0]
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
    puts win_message(@winner.name, @loser.name)
  end

  def tie
    puts tie_message(@players[0].name, @players[1].name)
  end

  def game_over
    if @game_board.victory?
      @active_player.fix_winner
      @game_complete = true
      @game_won = true
      true
    elsif @game_board.filled_up?
      @game_complete = true
      @game_won = false
      true
    end
    false
  end

  def play_game
    # Set @activeplayer.win = true in here. Call the win/tie methods appropriately. Call #switch_active_player only after running that check. Break if the check returns true.
    #if game_over
      #@game_won ? win : tie
      #break
    #end
  end

  def valid_replay_response?
  end

  def replay?
  end

  def game
  end
end

test = GamePlay.new
test.start_new_game
test.turn
test.switch_active_player
test.turn
test.turn
