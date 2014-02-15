require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "should show notice when no places were found" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end

  it "should show all returned places" do
    BeermappingApi.stub(:places_in).with("pasila").and_return(
        [ Place.new(name: "Pub East-West"), Place.new(name: 'Olutravintola Nurkka') ]
    )

    visit places_path
    fill_in('city', with: 'pasila')
    click_button "Search"

    expect(page).to have_content "East-West"
    expect(page).to have_content "Nurkka"
  end
end
