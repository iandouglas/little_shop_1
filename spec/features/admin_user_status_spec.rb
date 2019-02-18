require 'rails_helper'

RSpec.describe 'As an Admin', type: :feature do

  it 'lets an admin disable a user' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user_1 = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1@bob.net', password: 'password', role: 0)
    user_2 = User.create!(username: 'nothappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '2@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_users_path

    within "#user-#{user_1.id}" do
      click_button "Disable"
    end

    expect(path).to eq(admin_users_path)

    click_link 'Logout'
    click_link 'Log In'
    fill_in 'Email', with: '1@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq(login_path)
  end
end
