
require_relative "./display.rb"

class PlayerBreaker
  def initialize
  end

  def guessCode
  end
end

class ComputerBreaker

end

class GamePlay
include Display
  def initialize
    @guesses_left = 12
    @code = []
    @clue = []
  end

  def startGame
    introText
    choice = loop do
      currentChoice = gets.chomp
      break currentChoice if["1","2"].include? currentChoice
      puts "Please choose 1 or 2"
    end
    createPlayers(choice)
  end

  private
  def createPlayers(playerChoice)
    if playerChoice == "1"
      player = PlayerBreaker.new
      generateCode
      p @code.join
      textOne
      playRounds
    else
      textTwo
      @code = loop do
        currentChoice = gets.chomp
        break currentChoice if currentChoice.match? /[1-6][1-6][1-6][1-6]/
        puts "Please enter a 4-digit code of 1-6 only"
      end
      # createCode
      # playRounds
    end
  end

  def playRounds
    while @guesses_left > 0
      puts "ROUND #{13 - @guesses_left}"
      guess = loop do
        currentChoice = gets.chomp
        break currentChoice if currentChoice.match? /[1-6][1-6][1-6][1-6]/
        puts "Please enter a 4-digit code of 1-6 only"
      end
      checkGuess(guess.split(''), @code)
      @guesses_left -= 1
      puts "\nCLUE: #{@clue.join}"
      puts "#{@guesses_left} guesses left:"
      @clue.clear
    end
  end
    
  def generateCode
    for i in 1..4
      @code.push(rand(1..6).to_s)
    end
  end

  def checkGuess(guess, code)
    guess.each_with_index do |element, index|
      if code[index] == element
        @clue.push("X")
      elsif code.include? element
        @clue.push("O")
      else
        next
      end
    end
  end
end

newGame = GamePlay.new
newGame.startGame