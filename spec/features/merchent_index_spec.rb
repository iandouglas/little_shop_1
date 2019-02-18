require 'rails_helper'

RSpec.describe 'As a Visitor', type: :feature do
  describe 'when I visit /merchants' do
    it 'shows a list of all merchants, and their info' do
      user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)

      merchant_1 = User.create!(username: 'supperhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1tester@bob.net', password: 'password', role: 1)
      merchant_2 = User.create!(username: 'hellahappy', street: '432 main st', city: 'stephen', state: 'CO', zip_code: 80126, email: '2tester@bob.net', password: 'password', role: 1)
      merchant_3 = User.create!(username: 'nothappy', street: '432 main st', city: 'stephen', state: 'CO', zip_code: 80126, email: '3tester@bob.net', password: 'password', role: 1, enabled: 1)

      visit merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(page).to have_content("Name: supperhappy")
        expect(page).to have_content("City: steve")
        expect(page).to have_content("State: CO")
        expect(page).to have_content("Date Registered: #{merchant_1.created_at}")
      end
      within ".merchant-#{merchant_2.id}" do
        expect(page).to have_content("Name: hellahappy")
        expect(page).to have_content("City: stephen")
        expect(page).to have_content("State: CO")
        expect(page).to have_content("Date Registered: #{merchant_2.created_at}")
      end

      expect(page).to_not have_content("Name: nothappy")
    end

  end

end
