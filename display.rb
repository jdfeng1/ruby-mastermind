module Display
  def introText
    puts "Let's play Mastermind\n\n"
    puts "In this game, a code breaker attempts to discover a 4-digit code created by the code maker.\nEach turn, the code maker will reveal clues as to the correct numbers:\nX if there is a correct number in it's correct position\nO if there is a correct number in a wrong position\n"
    puts "\nChoose: Do you want to be CODE BREAKER or CODE MAKER?\n"
    puts "Press [1] for BREAKER\nPress [2] for MAKER\n"
  end

  def textOne
    puts "Code is set. Enter any 4-digit guess containing 1-6"
  end

  def textTwo
    puts "What would you like the code to be?"
  end
end