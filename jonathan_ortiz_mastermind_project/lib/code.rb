class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs)
    pegs.each do |peg|
      if !POSSIBLE_PEGS.has_key?(peg.upcase)
        return false
      end
    end
    return true
  end

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map{|peg| peg.upcase}
    else
      raise "invalid initialization"
    end
  end

  attr_reader :pegs

  def self.random(length)
    sequence = []
    peg_choices = "rgby"
    length.times do
      sequence << peg_choices[rand(0...4)]
    end
    return Code.new(sequence)
  end

  def self.from_string(pegs)
    chars = []
    pegs.each_char {|char| chars << char}
    return Code.new(chars)
  end

  def [](index)
    return @pegs[index]
  end

  def length
    return @pegs.length
  end

  def num_exact_matches(guess)
    count = 0
    @pegs.each_with_index do |peg, idx|
      if peg == guess[idx]
        count += 1
      end
    end
    return count
  end

  def num_near_matches(guess)
    count = 0
    num_pegs_guess = Hash.new(0)
    num_pegs = Hash.new(0)
    @pegs.each {|peg| num_pegs[peg] += 1}
    guess.pegs.each {|peg| num_pegs_guess[peg] += 1}
    
    near_matches = 0
    num_pegs_guess.each_key do |peg|
      if num_pegs_guess[peg] >= num_pegs[peg]
        near_matches += num_pegs[peg]
      else
        near_matches += num_pegs_guess[peg]
      end
    end
    return near_matches - num_exact_matches(guess)
  end

  def ==(arg)
    return arg.pegs == @pegs
  end
end
