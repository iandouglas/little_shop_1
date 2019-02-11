require 'spec_helper'

RSpec.describe 'as visitor', type: :feature do

  it 'allows me to register as a new user' do
    visit items_path

    click_link 'Register'

    fill_in :username, with: 'bob'
    fill_in :street, with: '123 main st'
    fill_in :city, with: 'denver'
    fill_in :state, with: 'CO'
    fill_in :zip_code, with: 80216
    fill_in :email, with: 'bob@bob.net'
    fill_in :password, with: 'password'
    fill_in :confirm_password, with: 'password'
    click_on 'Register'

    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome #{user.username}!")
  end
end
