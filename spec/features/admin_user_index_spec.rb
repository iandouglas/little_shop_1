require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do

  it 'lets an admin view a user showpage' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user_1 = User.create!(username: 'unhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1test@bob.net', password: 'password', role: 0)
    user_2 = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '2test@bob.net', password: 'password', role: 1)
    user_3 = User.create!(username: 'supperhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '3test@bob.net', password: 'password', role: 2)
    user_4 = User.create!(username: 'kindahappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '4test@bob.net', password: 'password', role: 0, enabled: 1)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    within '.navbar' do
      click_link 'Users'
    end

    expect(current_path).to eq(admin_users_path)

    within ".user-#{user_1.id}" do
      expect(page).to have_link("User: #{user_1.username}")
      expect(page).to have_content("Registered: #{user_1.created_at}")
      expect(page).to have_button("Disable")

    end

    within ".user-#{user_4.id}" do
      expect(page).to have_link("User: #{user_4.username}")
      expect(page).to have_content("Registered: #{user_4.created_at}")
      expect(page).to have_button("Enable")
    end

    click_link "User: #{user_1.username}"
    expect(current_path).to eq(admin_user_path(user_1))

  end

end
