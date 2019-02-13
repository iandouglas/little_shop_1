require 'rails_helper'

RSpec.describe 'navigation', type: :feature do

  it 'as a visitor' do
    user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
    merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@merch", password: "password", role: 1, enabled: 0)
    admin = User.create(username: 'admin', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@admin", password: "password", role: 2, enabled: 0)

    visit items_path
    click_link "Home"
    expect(current_path).to eq(root_path)

    visit new_user_path
    click_link "Items"
    expect(current_path).to eq(items_path)

    click_link "Merchants"
    expect(current_path).to eq(merchants_path)

    visit new_user_path
    click_link "Log In"
    expect(current_path).to eq(login_path)

    expect(page).to_not have_link('Profile')
    expect(page).to_not have_link('Orders')
    expect(page).to_not have_link('Logout')

    visit profile_path(user.id)
    expect(page).to have_http_status(404)

    visit profile_orders_path(user.id)
    expect(page).to have_http_status(404)
    visit logout_path
    expect(page).to have_http_status(404)
    visit dashboard_path(merchant)
    expect(page).to have_http_status(404)

  end

  describe 'as a user' do
    it 'should show the navbar' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit items_path
      click_link 'Profile'
      expect(current_path).to eq(profile_path)
      click_link 'Orders'
      expect(current_path).to eq(profile_orders_path)
      click_link 'Logout'
      expect(current_path).to eq(logout_path)

      visit dashboard_path(user)
      expect(page).to have_http_status(404)
    end
  end

  describe 'as a merchant' do
    it 'shows the navbar' do
      merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@merch", password: "password", role: 1, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit items_path
      click_link 'Dashboard'
      expect(current_path).to eq(dashboard_path(merchant))

      click_link 'Logout'
      expect(current_path).to eq(logout_path)

      visit profile_path(merchant)
      expect(page).to have_http_status(404)

      visit profile_orders_path(merchant)
      expect(page).to have_http_status(404)
    end
  end
end
