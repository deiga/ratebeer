require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating1) { FactoryGirl.create :rating, beer: beer1, user: user }
  let!(:rating2) { FactoryGirl.create :rating, beer: beer1, user: user }
  let!(:rating3) { FactoryGirl.create :rating, beer: beer2, user: user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
      }.to change{Rating.count}.by(1)

      expect(user.ratings.count).to eq(4)
      expect(beer1.ratings.count).to eq(3)
    end



    it "list matches to db" do
      visit ratings_path

      page.should have_content "Number of ratings: #{Rating.count}"

    end
  end
