class Game

  attr_accessor :code, :guess, :hint, :guess_history, :hint_history, :number_of_guesses

  def initialize(io = Kernel)
    @io = io
    @guess_history = ""
    @hint_history = ""
    @hint = []
  end

  def code
    @code = [:blue, :blue, :yellow, :red]
    #secret_code = Array.new(4) {|e| e = the_code[rand 3]}
  end

  def prompt

  end

  def guess
   # input = StringIO.new("blue,blue,red,yellow")
   #
   # $stdin = input
    @io.print "Enter a guess: "
    @guess = @io.gets.split(/,/).map{|i| i.to_sym}
  end

  def hint
     black_check = Array.new
     white_check = Array.new

    @code.each_with_index { |c, i|
      if(@guess[i] == c)
        black_check<<:black
        @guess[i] = nil
      else
        black_check<<:empty
      end
    }

    @code.each_with_index { |c, i|
      if(black_check[i] != :black)
        @guess.each_with_index do |g, i|
          if (g == c and white_check[i] != :white)
            @hint<<:white
            white_check[i] = :white
          end
        end
      end
    }

    black_check.each { |b|
      if(b == :black)
        @hint.insert(0,:black)
      end
    }
    @hint
  end

  def guess_history
    @guess_history<< @guess.join(" -- ")
    return @guess_history
  end

  def hint_history
    @hint_history<< @hint.join(" -- ")
    return @hint_history
  end

  def display_history
    line = "Guess: "
    line<< guess_history
    line<< "  |  Hint: "
    line<< hint_history
  end

  def intro
        line = "\t\t +++  MASTERMIND +++\n" +
        "Instructions: The computer randomly picks 4 pegs of either red, green, blue or yellow. You are to\n " +
        " guess the correct colors of the pegs in the right order. With each guess you could be given hint pegs.\n" +
        " A black hint peg means one of your colors is the right color in the right position. A white hint peg\n" +
        " means you have guessed a correct color, but it is in the wrong position. The game continues until you\n" +
        " have guessed the right combination of colors or you have ran out of guesses"
  end

  def run_game
    intro
    @number_of_guesses= 10

  end
end