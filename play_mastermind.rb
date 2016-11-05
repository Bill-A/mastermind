require_relative './mastermind'

# https://regex101.com
valid_guess = /[ROYGBIV][\s\,][ROYGBIV][\s\,][ROYGBIV][\s\,][ROYGBIV]/ix

my_game = Mastermind.new

puts "Let's Play Mastermind"
puts "Guess any combo of 4 colors: R,O,Y,G,B,I,V\n\n"
puts " Feedback is:"
puts "-------------"

loop do
  my_guess = gets.chomp.upcase
  case my_guess
    when valid_guess
      feedback = my_game.give_feedback(my_guess)
      puts "#{feedback}"
      break if my_game.game_over
    when 'QUIT', 'Q', 'EXIT', 'E'
      break
    else
      puts "Please enter your guess, any combination of 4 colors: R,O,Y,G,B,I,V\n\n"
  end
end

