require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { create :brewery, name:"Koff" }
  let!(:beer1) { create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { create :user }
  let!(:user2) { create :user, username: "Arto"}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)


    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end


    describe "is listed correctly" do
      before(:each) do
        create :rating, beer: beer1, user: user
        create :rating, beer: beer1, user: user
        create :rating, beer: beer2, user: user
      end

      it "number of ratings on list page is correct" do
        visit ratings_path

        expect(page).to have_content "Number of ratings: #{Rating.count}"
      end

      it "number of ratings on users page is correct" do
        visit user_path(user)

        expect(page).to have_content "Has #{user.ratings.count} rating"
      end
    end

    describe "interactions are commited to DB" do

      it "User clicks on delete removes for DB" do
        create :rating, beer: beer1, user: user

        visit user_path(user)

        expect {
          click_link 'delete'
          }.to change{Rating.count}.from(1).to(0)
        end
      end
    end
