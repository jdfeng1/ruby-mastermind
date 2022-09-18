
require_relative "./display.rb"

class Computer
  def initialize
    @response = []
    @last_guess = []
    @clue_storage = []
    @all_possible = []
  end

  def guess(round, prev_clue)
    if (prev_clue.include? "X") && (prev_clue.length < 4)
      for i in 1..prev_clue.count("X")
        @clue_storage.push((round - 1).to_s)
      end
    end
    if @clue_storage.length < 4
      @response = Array.new(4, round.to_s)
    else
      if prev_clue.length < 4
        @response = @clue_storage
        @all_possible = @response.permutation(4).to_a
      else
        @last_guess = @response
        @all_possible.filter! do |possibility|
          internalCheck(@last_guess, possibility) == prev_clue
        end
        @response = @all_possible.last
      end
    end
    @response
  end

  private
  
  def internalCheck(code, guess)
    clue = []
    code_check = code.clone
      guess.each_with_index do |element, index|
        if code_check[index] == element
          clue.push("X")
          code_check[index] = nil
        end
      end
      guess.each_with_index do |element, index|
        if code_check.include? element
          clue.push("O")
          code_check[code_check.index(element)] = nil
        end
      end
    clue
  end

end

class GamePlay
include Display
  def initialize
    @guesses_left = 12
    @code = []
    @clue = []
    @player = ""
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
      @player = "human"
      generateCode
      textOne
      playRounds
    else
      @player = "computer"
      textTwo
      createCode
      playComputer
    end
    playAgain?
  end

  def playComputer
    computerPlayer = Computer.new
    while @guesses_left > 0
      round = 13 - @guesses_left
      computer_guess = computerPlayer.guess(round, @clue)
      @clue.clear
      puts "\nROUND #{round}"
      puts "Computer Guess: #{computer_guess.join}"
      checkGuess(computer_guess, @code)
      @guesses_left -= 1
      puts "CLUE: #{@clue.sort.reverse.join}" unless @guesses_left <= 0
      sleep 1
    end
    if @guesses_left == 0
      puts "\nComputer lost :O Good code!\n"
    end
  end

  def playRounds
    while @guesses_left > 0
      round = 13 - @guesses_left
      puts "\nROUND #{round}"
      guess = loop do
        currentChoice = gets.chomp
        break currentChoice if currentChoice.match? /(?=^.{4}$)[1-6][1-6][1-6][1-6]/
        puts "Please enter a 4-digit code of 1-6 only"
      end
      checkGuess(guess.split(''), @code)
      @guesses_left -= 1
      puts "CLUE: #{@clue.sort.reverse.join}" unless @guesses_left <= 0
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
    code_input = loop do
      currentChoice = gets.chomp
      break currentChoice if currentChoice.match? /[1-6][1-6][1-6][1-6]/
      puts "Please enter a 4-digit code of 1-6 only"
    end
    @code = code_input.split("")
  end

  def checkGuess(guess, code)
    code_check = code.clone
    if guess == code_check
      @guesses_left = 0
      winnerText
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

  def winnerText
    if @player == "human"
      puts "You guessed the code!"
    else
      puts "Computer guessed the code!"
    end
  end

  def playAgain?
    puts "Play again? [Y/N]"
    choice = loop do
      currentChoice = gets.chomp.upcase
      break currentChoice if ["Y","N"].include? currentChoice 
      puts "Please select [Y]es or [N]o"
    end
    if choice == "Y"
      initialize
      startGame
    else
      puts "\nGoodbye\n"
    end
  end
end

newGame = GamePlay.new
newGame.startGame