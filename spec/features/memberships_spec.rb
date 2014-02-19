require 'spec_helper'

include OwnTestHelper

describe "Membership" do
  let!(:bc) { create :beer_club }
  let!(:user) { create :user }

  before :each do
    sign_in(username:user.username, password:"Foobar1")
  end

  it "should create an unconfirmed membership upon joining a club" do

    visit beer_club_path(BeerClub.first)
    expect { click_button 'Join the club' }.to change { Membership.count }.to(2)
    expect(Membership.order(:created_at).last.confirmed).to be false
  end

end
