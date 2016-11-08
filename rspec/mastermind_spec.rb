require './mastermind'

describe 'Mastermind' do
  # Red Orange Yellow Green Blue Purple

  before do
    allow_any_instance_of(Mastermind).to receive(:make_a_code).and_return("R,O,Y,G")
    @mastermind = Mastermind.new

  end

  it 'alway passes this test' do
    expect true
  end

  it 'has Code Master make a secret code' do
    expect(@mastermind.make_a_code).to eq("R,O,Y,G")
  end

  it 'Code Breaker guesses correct color and incorrect position, gets one white' do
    expect(@mastermind.give_feedback("B,Y,P,P")).to eq("W ")
  end

  it 'Code Breaker guesses correct color and correct position, correct color and incorrect position gets one red peg, one white peg' do
    expect(@mastermind.give_feedback("G,P,Y,I")).to include('W ', 'R ')
  end

  it 'Code Breaker guesses correct color and correct position, gets one red peg' do
    expect(@mastermind.give_feedback("B,P,P,G")).to eq("R ")
  end

  it 'Code Breaker guesses 4 same colors, correct color and correct position, gets one red peg' do
    expect(@mastermind.give_feedback("G,G,G,G")).to eq("R ")
  end

  it 'Code Breaker guesses 2x correct color and correct position, gets two red peg' do
    expect(@mastermind.give_feedback("R,P,Y,P")).to eq("R R ")
  end

  it 'Code Breaker guesses Repeat  (correct color and correct position), gets two red peg' do
    expect(@mastermind.give_feedback("R,O,R,O")).to eq("R R ")
  end

  it 'Code Breaker guesses incorrect color and incorrect position, gets no peg' do
    expect(@mastermind.give_feedback("B,P,B,P")).to eq("")
  end

  it 'looses game if Code Breaker has 10 or more attempts' do
    0.upto 9 do
      @mastermind.give_feedback("B,Y,P,0")
    end
    expect(@mastermind.give_feedback("B,Y,P,10")).to eq("10 Wrong Guesses,Game Over!")
  end

  it 'wins game if Code Breaker has 4 red pegs in 10 attempts or less' do
    0.upto 2 do
      @mastermind.give_feedback("B,Y,P,0")
    end
    expect(@mastermind.give_feedback("R,O,Y,G")).to start_with("R R R R ")
  end

end