require_relative '../kata'

describe P do

  specify "size defined by the class" do
    expect(P.size).to eq(5)
  end

  let (:id_map) {->(x){x}}
  let (:rot_map) {->(x) {x%P.size+1}}
  let (:id) {P.new(id_map)}
  let (:rot){P.new(rot_map)}

  specify "mapping given in the constructor" do
    expect(id).to_not be_nil
  end

  describe "array representation" do

    specify "for identity" do
      expect(id.to_a).to eq([1,2,3,4,5])
    end

    specify "for rotation" do
      expect(rot.to_a).to eq([2,3,4,5,1])
    end

  end

  it "operates on set elements" do
    expect(id[3]).to eq(3)
    expect(rot[3]).to eq(4)
    expect(rot[5]).to eq(1)
  end 

  it "supports composition with *" do
    expect((rot*rot).to_a).to eq([3,4,5,1,2])
  end

  it "can be created from a cycle" do
    expect(P.from_cycle([1,5,2]).to_a).to \
      eq([5,1,3,4,2])
  end
 
  context "cycle decompositon" do

    it "handles identity" 

    it "handles rotation" 

    it "handles combo" 

  end

end