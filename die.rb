class Color_Maker
  attr_accessor :number

  def initialize
    self.choose
  end

  def choose
    @number = (0..5).to_a.sample(4)
  end
end