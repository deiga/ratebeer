require 'spec_helper'

include OwnTestHelper

describe "Beer Club" do
  let!(:user) { create :user}
  before :each do
    sign_in(username:user.username, password:"Foobar1")
  end

  it "should add the creator of the club to member" do
    create_club

    bc = BeerClub.first
    expect(bc.members.count).to eq 1
    expect(bc.members.first).to eq user
  end

  it "should add the club to the database" do
    visit new_beer_club_path

    fill_in 'Name', with: 'Test club'
    fill_in 'Founded', with: Date.new.year
    fill_in 'City', with: 'Helsinki'

    expect { click_button 'Save' }.to change{BeerClub.count}.from(0).to(1)
  end
end
