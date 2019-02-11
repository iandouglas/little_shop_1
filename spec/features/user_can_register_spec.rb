require 'rails_helper'

RSpec.describe 'as visitor', type: :feature do

  it 'allows me to register as a new user' do
    visit items_path

    click_link 'Register'

    fill_in 'Username', with: 'bob'
    fill_in 'Street', with: '123 main st'
    fill_in 'City', with: 'denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: 80216
    fill_in 'Email', with: 'bob@bob.net'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm password', with: 'password'
    click_on 'Register Now'

    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome #{user.username}!")
  end
end
