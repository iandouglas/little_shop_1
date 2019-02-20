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
    end
  end
end
