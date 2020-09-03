# frozen_string_literal: true

require_relative 'board.rb'

class Player
  attr_accessor :name, :token, :win, :taken_tokens
  attr_reader :TOKENS

  TOKENS = [nil, "\u2b24".yellow, "\u2b24".red, "\u2b24".green, "\u2b24".blue, "\u2b24".magenta, "\u2b24".teal]
  @@taken_tokens = []

  def initialize
    @name = ''
    @token = ''
    @win = false
  end

  def input_name_of_player(player_number)
    puts "\nPlayer #{player_number}, what is your name?".teal
    print '[name]: '
    name = gets.chomp
    @name = name
  end

  def input_token
    show_token_options
    puts ''
    loop do
      print '[Token choice]: '
      chosen_token = gets.chomp.to_i
      valid = valid_token?(chosen_token)
      if valid
        @@taken_tokens << TOKENS[chosen_token]
        @token = TOKENS[chosen_token]
        break
      end
      puts "\nPlease choose a token that has not been chosen by the other player!".red if valid == false
      puts "\nPlease input your choice as a number between 1 and 6.".red if valid == nil
    end
  end

  def fix_winner
    @win = true
  end

  private

  def show_token_options
    puts "\nWelcome, #{@name}! Please choose one of the following tokens to play using.".teal
    puts "1. #{TOKENS[1]}\t\t2. #{TOKENS[2]}\t\t3. #{TOKENS[3]}\n4. #{TOKENS[4]}\t\t5. #{TOKENS[5]}\t\t6. #{TOKENS[6]}"
  end

  def valid_token?(token_number)
    return nil unless token_number.between?(1, 6)
    chosen_token = TOKENS[token_number]
    !@@taken_tokens.include?(chosen_token)
  end
end
