require_relative 'board.rb'

module Instructions
  def logo
      "
           ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗ ██████╗████████╗    ███████╗ ██████╗ ██╗   ██╗██████╗ 
          ██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝██╔════╝╚══██╔══╝    ██╔════╝██╔═══██╗██║   ██║██╔══██╗
          ██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║        ██║       █████╗  ██║   ██║██║   ██║██████╔╝
          ██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║        ██║       ██╔══╝  ██║   ██║██║   ██║██╔══██╗
          ╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗╚██████╗   ██║       ██║     ╚██████╔╝╚██████╔╝██║  ██║
           ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═╝       ╚═╝      ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
                                                                                                        ".teal
  end

  def introduction
    "In this hopefully nostalgia-inducing match, two players will be playing against each other.\nThe aim of the game is to be the first to place four tokens of your kind next to each other before your opponent does.\nThey may be placed adjacent to each other in a row, in a column, or even diagonally.\nAs long as four of a kind " + "(your kind)".magenta + " are next to each other, " + "you win!\n".magenta + "Make sure to keep an eye on your opponent's moves and block them when you need to.\n" + "\nWhew, that was a lot of talk but you guys get the gist. Time to get right down to it.".magenta
  end

  def win_message(winner_name, loser_name)
    "\nCongratulations, #{winner_name}! Give yourself a treat and a pat on the back because you've beat out #{loser_name} real good."
  end

  def tie_message(player1name, player2name)
    "What a conundrum, fellas. The game's over and there's no clear winner. Maybe you two can practice your sharing skills, #{player1name} and #{player2name}."
  end

  def leave_message
    'Well, that was fun while it lasted, you two. In the words of Groucho Marx, "Go, and never darken my towels again."'.teal + "\n(No, but seriously though, you can come back anytime! :) )".magenta
  end
end