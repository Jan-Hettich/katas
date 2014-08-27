# FizzBuzz

class FizzBuzz
  include Enumerable

  def initialize
    @underlying = (1..Float::INFINITY).lazy
  end

  def each
    @underlying.map{|n| [n, ""]} \
      .map{|r| self.class.append_if_divisible_by(3, 'Fizz', r)}
      .map{|r| self.class.append_if_divisible_by(5, 'Buzz', r)}
      .map{|r| r[1].length > 0 ? r : [r[0], r[0].to_s]}
      .each do |r|
        yield r
    end
  end

  class << self

    def append_if_divisible_by(n, s, r)
      return r unless r[0] % n == 0
      s = " " + s if r[1].length > 0
      [r[0], r[1] + s]
    end

  end

end


 

