require 'spec_helper'

describe Beer do
  it "is not saved without name" do
    beer = Beer.create style:'Lager'

    beer.should_not be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    beer = Beer.create name:'Lager'

    beer.should_not be_valid
    expect(Beer.count).to eq(0)

  end

  describe "with name and style" do
    let(:beer) {Beer.create name:'foo', style:'bar'}

    it "is saved" do
      beer.should be_valid
      Beer.count.should eq(1)
    end
  end

end
