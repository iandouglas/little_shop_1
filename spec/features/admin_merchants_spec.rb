require 'rails_helper'

RSpec.describe 'as admin', type: :feature do


  describe 'when visiting the merchant index page' do
    before(:each) do
      @admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
      @merchant = User.create!(username: 'unhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1test@bob.net', password: 'password', role: 1)
      visit login_path
      fill_in 'Email', with: 'test@bob.net'
      fill_in 'Password', with: 'password'
      click_button 'Sign In'
    end

    it 'merchants names should link to thier show page' do
      visit merchants_path

      click_link "#{@merchant.username}"

      expect(current_path).to eq(admin_merchant_path(@merchant))
      expect(page).to have_content("Name: #{@merchant.username}")
      expect(page).to have_content("Street Address: #{@merchant.street}")
      expect(page).to have_content("City: #{@merchant.city}")
      expect(page).to have_content("State: #{@merchant.state}")
      expect(page).to have_content("Zip Code: #{@merchant.zip_code}")
      expect(page).to have_content("Email: #{@merchant.email}")
      expect(page).to_not have_content(@merchant.password)
    end
  end
end
