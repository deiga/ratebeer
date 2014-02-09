require 'spec_helper'

describe "Beer" do
  before :each do
    FactoryGirl.create :beer
  end


  it "is created with non-empty name" do
    visit new_beer_path

    fill_in('Name', with: 'Test beer')

    expect {
      click_button 'Save'
    }.to change{Beer.count}.by(1)

  end

  it "is not created with empty name" do
    visit new_beer_path

    expect {
      click_button 'Save'
    }.to change{Beer.count}.by(0)
  end

end
