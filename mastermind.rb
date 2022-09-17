
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
        break currentChoice if currentChoice.match? /(?=^.{4}$)[1-6][1-6][1-6][1-6]/
        puts "Please enter a 4-digit code of 1-6 only"
      end
      checkGuess(guess.split(''), @code)
      @guesses_left -= 1
      puts "\nCLUE: #{@clue.sort.reverse.join}" unless @guesses_left <= 0
      @clue.clear
    end
    if @guesses_left == 0
      puts "\nSorry, you lost :( The code was #{@code.join}\n"
    end
  end
    
  def generateCode
    for i in 1..4
      @code.push(rand(1..6).to_s)
    end
  end

  def createCode

  end

  def checkGuess(guess, code)
    code_check = code.clone
    if guess == code_check
      puts "\nYou guessed the code!"
      @guesses_left = 0
    else
      guess.each_with_index do |element, index|
        if code_check[index] == element
          @clue.push("X")
          code_check[index] = nil
        end
      end
      guess.each_with_index do |element, index|
        if code_check.include? element
          @clue.push("O")
          code_check[code_check.index(element)] = nil
        end
      end
    end
  end
end

newGame = GamePlay.new
newGame.startGame