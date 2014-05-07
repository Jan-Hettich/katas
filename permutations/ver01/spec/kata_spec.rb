require_relative '../kata'

describe P do

  let (:n) {5}
  let (:i_map) {->(x){x}}
  let (:r_map) {->(x){x%n+1}}
  let (:id) {P.new(n,i_map)}
  let (:rot) {P.new(n, r_map)}

  it "is defined by a size and a mapping" do
    expect(id).to_not be_nil
  end

  describe "array representation" do
    let(:n) {3}

    it "describes identity" do
      expect(id.to_a).to eq([1,2,3])
    end

    it "describes rotation" do
      expect(rot.to_a).to eq([2,3,1])
    end

  end

  it "operates on set elements" do
    expect(id[3]).to eq(3)
    expect(rot[1]).to eq(2)
    expect(rot[n]).to eq(1)
  end

  it "supports composition with *" do
    expect((rot*rot).to_a).to \
      eq([3,4,5,1,2])
  end

  it "can be created from a cycle" do
    expect(P.from_cycle(5, [1,5,2]).to_a).to \
      eq([5,1,3,4,2])
  end
 
  context "cycle decompositon" do

    it "handles identity" do 
      expect(id.cycles).to \
        eq((1..5).each_slice(1).to_a)
    end

    it "handles rotation" do
      expect(rot.cycles).to eq([[1,2,3,4,5]]) 
    end

    let (:combo) {P.from_cycle(5,[1,5,2]) *
      P.from_cycle(5,[3,4])}

    it "validates combo" do
      expect(combo.to_a).to eq([5,1,4,3,2])
    end 
 
    it "handles combo" do
       expect(combo.cycles).to \
         eq([[1,5,2],[3,4]])
    end

  end

end