
require_relative "./display.rb"

class Player
  
end

class Human < Player
  
end

class Computer < Player

end

class GameExecute
include Display
  def initialize
    @guesses_left = 12
    @code = nil
  end

  def startGame
    introText
    choice = loop do
      currentChoice = gets.chomp
      break currentChoice if["1","2"].include? currentChoice
      puts "Please choose 1 or 2"
    end
    p choice
    createPlayers(choice)
  end
  
  def createPlayers(playerChoice)
    
  end

end

newGame = GameExecute.new
newGame.startGame