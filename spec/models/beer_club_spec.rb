require 'spec_helper'

describe BeerClub do

  it "should create a club with 1 member" do
    bc = create :beer_club

    expect(BeerClub.count).to eq 1
    expect(bc.members.count).to eq 1
    expect(Membership.count).to eq 1
  end
end
