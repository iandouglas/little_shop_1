require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do

  it 'lets an admin view a user showpage' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_show_path(user)

    expect(current_path).to eq(admin_user_show_path(user))
    expect(page).to have_content("Welcome test!")
    expect(page).to have_content("Name: #{user.username}")
    expect(page).to have_content("Street Address: #{user.street}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip Code: #{user.zip_code}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Edit Profile")
  end

  it 'lets an admin edit a users information' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_show_path(user)

    click_link 'Edit Profile'
    # save_and_open_page
    expect(current_path).to eq(edit_profile_path)

    fill_in 'City', with: 'happy steve'
    click_button 'Save Changes'

    expect expect(current_path).to eq(admin_user_show_path(user))
    expect(page).to have_content("City: happy steve")
  end


end
