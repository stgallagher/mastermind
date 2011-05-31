class Game

  attr_accessor :code, :guess, :hint, :guess_line, :hint_line, :history, :number_of_guesses_left

  def initialize(io = Kernel)
    @io = io
    @code = Array.new(4)
    @hint = []
    @guess_line = ""
    @hint_line = ""
    @history = ""
    @number_of_guesses_left = 10
  end

  def set_secret_code
    possible_colors = [:blue, :red, :green, :yellow]
    @code.map! do |e|
      e = possible_colors[rand 4]
    end
  end

  def guess
    @number_of_guesses_left -= 1
    @io.print "Enter a guess: "
    input = @io.gets.strip
    @guess = input.split(/,/).map{|i| i.to_sym}

  end

  def get_hint
     black_check = Array.new
     white_check = Array.new

     guess_copy = @guess.dup
    @hint = []

    @code.each_with_index{ |c, i|
      if(guess_copy[i] == c)
        black_check<<:black
        guess_copy[i] = nil
      else
        black_check<<:empty
      end
    }

    @code.each_with_index do |c, j|
      if(black_check[j] != :black)
        found = false
        guess_copy.each_with_index do |g, i|
          if (g == c and found == false and white_check[i] != :white)
            @hint<<:white
            found = true
            white_check[i] = :white
          end
        end
      end
    end

    black_check.each { |b|
      if(b == :black)
        @hint.insert(0,:black)
      end
    }
    @hint
  end

  def guess_line
    @guess_line = @guess.join(" -- ")
    @guess_line
  end

  def hint_line
    @hint_line = @hint.join(" -- ")
    @hint_line
  end

  def display_line
    guess_number = (10 - @number_of_guesses_left)
    line = "\nGuess number #{guess_number}: "
    line<< guess_line.strip
    line<< " |  Hint: "
    line<< hint_line
    line<< "\n\n"
    line
  end

  def display_history
    @history<< display_line
    @history
  end

  def display_guesses_remaining
   line = "You have #{number_of_guesses_left} guesses remaining\n\n"
   line
  end

  def won?
    if(@guess == @code)
      code_text = @code.collect { |x| x.to_s + " "}
      puts "Congratulations! You guessed the code!!! It was #{code_text}. Good Job."
      true
    else
      false
    end
  end

  def lost?
    if(number_of_guesses_left == 0)
      code_text = @code.collect { |x| x.to_s + " "}
      puts "Sorry, you ran out of guesses. The secret code was #{code_text}"
      true
    else
      false
    end
  end

  def intro
        line = "\t\t +++  MASTERMIND +++\n" +
        "Instructions: The computer randomly picks 4 pegs of either red, green, blue or yellow. You are to\n " +
        " guess the correct colors of the pegs in the right order. With each guess you could be given hint pegs.\n" +
        " A black hint peg means one of your colors is the right color in the right position. A white hint peg\n" +
        " means you have guessed a correct color, but it is in the wrong position. The game continues until you\n" +
        " have guessed the right combination of colors or you have ran out of guesses\n\n"
  end

  def run_game
    print intro
    set_secret_code
    until (won? or lost?) do
      guess
      if(won?)
        break
      end
      get_hint
      print display_history
      print display_guesses_remaining
    end
  end

  class App
  game = Game.new
  game.run_game
  end
end