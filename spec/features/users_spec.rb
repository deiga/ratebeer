require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match!'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user[username]', with:'Brian')
    fill_in('Password', with:'Secret55')
    fill_in('Password confirmation', with:'Secret55')

    expect{
      click_button('Create user')
    }.to change{User.count}.by(1)
  end
end