require_relative '../kata'

describe "FizzBuzz" do

  let(:fb) {FizzBuzz.new}
  let(:n) {100}

  it "is defined" do
    expect(FizzBuzz).not_to be_nil
  end

  specify "first(10) returns 10 elements" do
    expect(fb.first(10).count).to eq(10)
  end

  specify "first(20) returns 20 elements" do
    expect(fb.first(20).count).to eq(20)
  end

  it "returns array of [int, String]" do
    expect{fb.first(n).each do |r| 
      if !r.is_a?(Array) || 
        r.count != 2 ||
        !r[0].is_a?(Integer) || 
        !r[1].is_a?(String)
        raise "not [int,string]: #{r}"
      end
    end}.not_to raise_error
  end

  it "says 'Fizz' if divisible by 3" do
    expect{fb.first(n).each do |r|
      if r[0] % 3 == 0 && /Fizz/ !~ r[1]
        raise "drink #{r}"
      end
    end}.not_to raise_error   
  end

  it "says 'Buzz' if divisible by 5" do
    expect{fb.first(n).each do |r|
      if r[0] % 5 == 0 && /Buzz/ !~ r[1]
        raise "drink #{r}"
      end
    end}.not_to raise_error   
  end

  it "says 'Fizz Buzz' if divisible by 15" do
    expect{fb.first(n).each do |r|
      if r[0] % 15 == 0 && /Fizz Buzz/ !~ r[1]
        raise "drink #{r}"
      end
    end}.not_to raise_error   
  end

  it "says the number otherwise" do
    expect{fb.first(n).each do |r|
      if r[1] !~ /[Fizz|Buzz]/ && r[1] != r[0].to_s
        raise "drink #{r}"
      end
    end}.not_to raise_error   
  end


  describe "append_if_divisible_by(n, s, r)" do

    it "adds 'Fizz' if divisible by 3" do
      expect(FizzBuzz.append_if_divisible_by 3, 'Fizz', [6, ""]).to \
        eq([6, "Fizz"])
    end

    it "returns unchanged array if not divisible by 3" do
      expect(FizzBuzz.append_if_divisible_by 3, 'Fizz', [7, ""]).to \
        eq([7, ""])
    end

  end

  
end
