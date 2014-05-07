# Permutations

require_relative "../kata"

describe P do

  let(:p) {P.new(2,5,4,3,1)}
  let(:q) {P.new(3,1,2,4,5)}
  let(:i) {P.new(1,2,3,4,5)}

  it "can be instantiated" do
    expect(p).not_to be_nil
  end

  it "rejects input if not 1-1" do
    expect{P.new(1,2,1)}.to raise_error(RuntimeError,
          "not a valid permutation")
  end

  it "rejects input with gaps" do
    expect{P.new(2,1,4)}.to raise_error(RuntimeError,
      "not a valid permutation")
  end

  it "has size property" do
    expect(p.size).to equal(5)
  end

  it "has a to_s method" do
    expect(p.to_s).to eq("P:[2, 5, 4, 3, 1]")
  end

  it "can be resized (self)" do
    p1 = p.resize!(7)
    expect(p.to_s).to eq("P:[2, 5, 4, 3, 1, 6, 7]")
    expect(p1.equal?(p)).to be_true 
  end

  it "does nothing if resized to same size" do
    expect(p.resize!(p.size).size).to eq(p.size) 
  end

  it "can only be increased in size" do
    expect{p.resize!(4)}.to raise_error(RuntimeError,
      "cannot resize smaller")
  end

  it "can be duplicated" do
    p1 = p.dup
    expect(p1.equal?(p)).to be_false
  end

  it "makes deep copy when duplicated" do
    p1 = p.dup
    p.resize!(7)
    expect(p1.size).to eq(5)
  end

  it "can be compared for equality" do
    expect(p.dup == p).to be_true
  end

  it "matches when equal on the mutated subset" do
    expect(p.dup.resize!(7) === p.dup).to be_true
  end

  context "when applied as a mapping" do

    it "can be applied to an element of the set" do
      expect(p[3]).to eq(4)
    end

    it "has a to_proc method" do
      expect(p.to_proc[3]).to eq(4)
      expect(P.new *(1..5).map(&p)).to eq(p)
    end

    it "is composable" do
      expect(q.compose(p)).to eq(P.new(1,5,4,2,3))
    end

    it "is composable (as proc)" do
      s = q.compose(p)
      expect((1..5).map(&s)).to eq((1..5).map(&p).map(&q))
    end

    it "has [1,2,3,4,5] as identity mapping" do
      expect(i.compose(p)).to eq(p.compose(i))
    end

  end

  context "construction from cycle" do

    let (:c1){[1,3,2]}

    it "can be created from a cylce" do
      expect(P.from_cycle(c1,5)).to be_an_instance_of P
      expect(P.from_cycle(c1,5).to_s).to eq("P:[3, 1, 2, 4, 5]")
    end

    it "converts empty cycle to the identity perm" do
      expect(P.from_cycle([],5)).to eq(P.new(1,2,3,4,5))
    end

  end 

  context "cycle decomposition" do

    it "breaks [1,2,3,4,5] into [1],[2],[3],[4],[5]" do
      expect(i.cycles).to eq([[1],[2],[3],[4],[5]])
    end

    it "correctly breaks p" do
      expect(p.cycles).to eq([[1,2,5],[3,4]])
    end

    it "correctly breaks q" do
      expect(q[1]).to eq(3)
      expect(q.cycles).to eq([[1,3,2],[4],[5]])
    end

  end

  it "computes the order of a permutation" do
    expect(p.order).to eq(3)
    expect(q.order).to eq(2)
  end

  it "computes the sign of a permutation" do
    expect(p.sign).to eq("-")
    expect(q.sign).to eq("+")
  end

end
