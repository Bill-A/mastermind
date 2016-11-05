class Mastermind

  Red = 'R'
  Orange = 'O'
  Yellow = 'Y'
  Green = 'G'
  Blue = 'B'
  Indigo = 'I'
  Violet = 'V'
  COLOR_PEGS = [Red, Orange, Yellow, Green, Blue, Indigo, Violet]


  attr_reader :guess_count, :game_over

  def initialize
    @guess_count = 0
    @secret_code = make_a_code
    @game_over = false
  end

  def make_a_code
    code = []

    time = Time.new

    color_index = (0..6).to_a.sample(4)
    code = "#{COLOR_PEGS[color_index[0]]},#{COLOR_PEGS[color_index[1]]},#{COLOR_PEGS[color_index[2]]},#{COLOR_PEGS[color_index[3]]}"

    open('secret_codes.txt', 'a') do |f|
      f.puts "Game started at: #{time.ctime}\n"
      f.puts "The secret code is #{code}\n"
    end

    return code

  end

  def give_feedback(guess)
    peg_feedback = ''
    i = 0

    secret_code_tokens = @secret_code.split(',')
    guess_tokens = guess.split(',')


    if guess_tokens == secret_code_tokens
      @game_over = true
      peg_feedback = 'R R R R '
      return "#{peg_feedback}\nYou correctly guessed the code: #{@secret_code}"
    else
      secret_code_tokens.each_index { |i|
        if secret_code_tokens[i] == guess_tokens[i]
          peg_feedback.concat('R ')
          guess_tokens[i] = ''
          i+1.upto(guess_tokens.size-1) do |loc|
            if secret_code_tokens[i] == guess_tokens[loc]
              guess_tokens[loc] = ''
            end
          end
        end
      }

      guess_tokens.each { |g|
        peg_feedback.concat('W ') if secret_code_tokens.include? g
      }

      @guess_count += 1

      if @guess_count >= 10
        @game_over = true
        return "10 Wrong Guesses,Game Over!"
      end

      return peg_feedback
    end


  end


end

