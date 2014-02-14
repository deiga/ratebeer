require 'spec_helper'

describe User do

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with a too short password" do
    let(:user){ FactoryGirl.build(:user,password:"Secr", password_confirmation:"Secr") }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe "with an password in wrong format" do
    let(:user){ FactoryGirl.build(:user,password:"secret1", password_confirmation:"secret1") }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe "favourite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favourite_beer
    end

    it "without ratings does not have one" do
      expect(user.favourite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favourite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favourite_style
    end

    it "without ratings does not have one" do
      expect(user.favourite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating_and_style(25, user, 'IPA')

      expect(user.favourite_style).to eq(best.style)
    end
  end

  describe "favourite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favourite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favourite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_brewery).to eq(beer.brewery)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating_and_brewery(25, user, name:'BrewDog', year:1999)

      expect(user.favourite_brewery).to eq(best.brewery)
    end
  end

end

def create_beer_with_rating_and_brewery(score, user, brewery)
  beer = FactoryGirl.create(:beer, brewery: FactoryGirl.create(:brewery, brewery))
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beer_with_rating_and_style(score, user, style)
  beer = FactoryGirl.create(:beer, style: style)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end
