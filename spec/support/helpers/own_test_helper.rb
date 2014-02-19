module OwnTestHelper
  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_club
    visit new_beer_club_path

    fill_in 'Name', with: 'Test club'
    fill_in 'Founded', with: Date.new.year
    fill_in 'City', with: 'Helsinki'

    click_button 'Save'
  end
end
