require 'spec_helper'

describe Beer do
  it "is not saved without name" do
    beer = build :beer, name: nil

    expect(beer).not_to be_valid
    expect {
      beer.save }.not_to change{Beer.count}
  end

  it "is not saved without style" do
    beer = build :beer, name:'Lager', style: nil

    expect(beer).not_to be_valid
    expect {
      beer.save }.not_to change{Beer.count}

  end

  describe "with name and style" do
    let(:beer) {create :beer, name:'foo'}

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

end
