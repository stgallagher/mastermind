$: << File.dirname(__FILE__) + "/../lib"

require "rubygems"
require "rspec"
require "game.rb"
require "mock_kernel.rb"

describe Game do
  it "can be instantiated" do
    game = Game.new
    game.should_not be(nil)
  end

  it "starts with a secret code" do
    game = Game.new
    game.code.should_not be(nil)

  end

  it "secret code should contain 4 elements" do
    game = Game.new
    game.code.size.should == 4
  end

  it "secret code should hold four symbols" do
    game = Game.new
    game.code.each {|i| i.class.should == Symbol}
  end

  it "the symbols held in the secret code should be equal to red, yellow, blue or green" do
    game = Game.new

    index = 0
    test_array = Array.new(4, "fail")
    test_colors = [:red, :yellow, :blue, :green]

    game.code.each {|i|
      test_colors.each {|test|
        if test == i
        test_array[index] = "pass"
        index +=1
        end
      }
    }
    test_array.should == ["pass", "pass", "pass", "pass"]
  end

  it "the computer should randomly choose four colors for the secret code" do
    game1 = Game.new
    game2 = Game.new

#    game1.code.should_not == game2.code
  end

#  it "should have a prompt message that asks the user for a guess" do
#    game = Game.new
#    game.prompt.should_not == nil
#    game.prompt.class.should == String
#  end

  it "the user should be able to enter a guess" do
    game = Game.new
    game.guess.should_not == nil
  end

  it "hint method should not be empty" do
    game = Game.new
    game.code= [:empty, :empty, :empty, :empty]
    game.guess= [:empty, :empty, :empty, :empty]
    game.hint.should_not == nil
  end

  it "should create a set of hint pegs" do
    game = Game.new
    game.code= [:empty, :empty, :empty, :empty]
    game.guess= [:empty, :empty, :empty, :empty]
    game.hint.class.should == Array
  end

  it "hint set should be of length 4" do
    game = Game.new
    game.code= [:empty, :empty, :empty, :empty]
    game.guess= [:empty, :empty, :empty, :empty]
    game.hint.size.should == 4
  end

  it "hint set should be 4 symbols" do
    game = Game.new
    game.code= [:empty, :empty, :empty, :empty]
    game.guess= [:empty, :empty, :empty, :empty]
    game.hint.each {|i| i.class.should == Symbol}
  end

  # hint set is based on matching the guess set to the code set. If there is a match of color and position, then a
  # black peg is added to the hint set. If there is a match of color but not position, a white peg is added to the
  # hint set.

  it "hint set should yield 4 black pegs if both guess and code match" do
      game = Game.new
      game.guess= [:red, :red, :red, :red]
      game.code= [:red, :red, :red, :red]
      game.hint.should == [:black, :black, :black, :black]
  end

  it "hint set should yield empty if no colors match between the guess and code match" do
      game = Game.new
      game.guess= [:green, :green, :green, :green]
      game.code= [:red, :red, :red, :red]
      game.hint.should == []
  end

  it "hint set should yield [:black, :black] if guess = [blue, red, red, red] and code = [blue, green, yellow, red]" do
      game = Game.new
      game.guess = [:blue, :red, :red, :red]
      game.code = [:blue, :green, :yellow, :red]
      game.hint.should == [:black, :black]
  end

  it "hint set should yield [:black, :black, :white, :white] if guess = [blue, blue, red, yellow] and
      code = [blue, blue, yellow, red]" do
      game = Game.new

      game.guess = [:blue, :blue, :red, :yellow]
      game.code = [:blue, :blue, :yellow, :red]
      game.hint.should == [:black, :black, :white, :white]
  end

  it "hint set should yield [:white, :white, :white, :white] if guess = [blue, blue, red, yellow] and
      code = [red, yellow, blue, blue]" do
      game = Game.new

      game.guess = [:blue, :blue, :red, :yellow]
      game.code = [:red, :yellow, :blue, :blue]
      game.hint.should == [:white, :white, :white, :white]
  end

   it "hint set should yield [:black, :black, :white, :white] if guess = [blue, blue, red, yellow] and
      code = [blue, yellow, red, blue]" do
      game = Game.new

      game.guess = [:blue, :blue, :red, :yellow]
      game.code = [:blue, :yellow, :red, :blue]
      game.hint.should == [:black, :black, :white, :white]
   end

  it "hint set should yield [:black, :white, :white, :white] if guess = [blue, yellow, red, green] and
      code = [yellow, green, red, blue]" do
      game = Game.new

      game.guess = [:blue, :yellow, :red, :green]
      game.code = [:yellow, :green, :red, :blue]
      game.hint.should == [:black, :white, :white, :white]
  end

  it "hint set should yield [:black] if guess = [blue, blue, red, yellow] and
      code = [blue, green, green, green]" do
      game = Game.new

      game.guess = [:blue, :blue, :red, :yellow]
      game.code = [:blue, :green, :green, :green]
      game.hint.should == [:black]
  end

   it "hint set should yield [:white] if guess = [blue, blue, red, red] and
      code = [blue, green, green, green]" do
      game = Game.new

      game.guess = [:red, :blue, :red, :red]
      game.code = [:blue, :green, :green, :green]
      game.hint.should == [:white]
   end

   it "history should display something" do
    game = Game.new

    game.guess = [:red, :blue, :red, :red]
    game.guess_history.should_not == nil
   end

  it "history should display a guess" do
    game = Game.new
    game.guess = [:red, :blue, :red, :red]
    game.guess_history.should == "red -- blue -- red -- red"
  end

  it "history should display a history with multiple guesses" do
    game = Game.new
    game.guess = [:red, :blue, :red, :red]
    game.guess_history
    game.guess = [:green, :green, :red, :red]
    game.guess_history.should == "red -- blue -- red -- red" + "green -- green -- red -- red"
  end

  it "hint history should display a hint" do
    game = Game.new
    game.guess = [:blue, :blue, :red, :yellow]
    game.code = [:red, :yellow, :blue, :blue]
    game.hint
    game.hint_history.should == "white -- white -- white -- white"
  end

  it "display_history should display a complete line of history" do
    game = Game.new
    game.guess = [:blue, :blue, :red, :yellow]
    game.code = [:red, :yellow, :blue, :blue]
    game.hint
    game.display_history.should == "Guess: blue -- blue -- red -- yellow  |  Hint: white -- white -- white -- white"
  end

  it "intro should display game title and instructions" do
    game = Game.new
    game.intro.should == "\t\t +++  MASTERMIND +++\n" +
        "Instructions: The computer randomly picks 4 pegs of either red, green, blue or yellow. You are to\n " +
        " guess the correct colors of the pegs in the right order. With each guess you could be given hint pegs.\n" +
        " A black hint peg means one of your colors is the right color in the right position. A white hint peg\n" +
        " means you have guessed a correct color, but it is in the wrong position. The game continues until you\n" +
        " have guessed the right combination of colors or you have ran out of guesses"
    end

  it "prompt should receive a guess input from user" do
    io = MockKernel.new
    game = Game.new(io)
    io.gets_values<< "red,red,red,red"

    game.guess.should == "red,red,red,red"
    end
end

