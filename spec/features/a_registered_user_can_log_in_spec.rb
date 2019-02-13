require 'rails_helper'

RSpec.describe "Login and Logout", type: :feature do

  describe 'as a visitor' do
    it 'I can no log in with invalid credentials' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: user.email
      fill_in :password, with: "psswrd"

      click_button 'Sign In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("The given credentials were incorrect")
    end
  end

  describe "As a registered user" do
    it "Logs me in and redirect me to my profile page" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "a12345@54321", password: "password", role: 0, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button 'Sign In'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are now logged in")

    end

    it 'redirects me to my profile if already logged in' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345awq@5asew4321", password: "password", role: 0, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button 'Sign In'

      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have already logged in")
    end

    it 'logs a user out' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button 'Sign In'

      visit login_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You have successfully logged out")
      visit items_path
      expect(page).to have_content("Cart: 0")
    end
  end

  describe "As a Merchant User" do
    it "Logs me in and redirects me to my merchant dashboard" do
      merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@merch", password: "password", role: 1, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password

      click_button 'Sign In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You are now logged in.")
    end
    it 'redirects me to my Merchant Dashboard if already logged in' do
      merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@merch", password: "password", role: 1, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password

      click_button 'Sign In'

      visit login_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You have already logged in.")
    end
  end


  describe "As an Andmin User" do
    it 'logs me in and redirects me to the homepage of the site' do
      admin = User.create(username: 'admin', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@admin", password: "password", role: 2, enabled: 0)
      visit root_path

      click_link 'Log In'

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password

      click_button 'Sign In'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are now logged in.")
    end

    it 'redirects me to the Admin Dashboard if already logged in' do
      admin = User.create(username: 'admin', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@admin", password: "password", role: 2, enabled: 0)

      visit root_path

      click_link 'Log In'

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password

      click_button 'Sign In'

      visit login_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You have already logged in.")
    end
  end
end
