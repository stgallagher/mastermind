class MockKernel

  attr_accessor :gets_values,:puts_values,:print_values

  def initialize
    @gets_values = []
    @puts_values = []
    @print_values = []
  end

  def gets
    @gets_values.shift
  end

  def puts(message)
    @puts_values << message
  end

  def print(message)
    @print_values << message
  end

end