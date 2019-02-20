require 'rails_helper'

RSpec.describe 'as an admin' do
  describe 'when I visit view the merchants index' do
    it 'shows a list of all merchants and their info' do
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)

      merchant_1 = User.create!(username: 'supperhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1tester@bob.net', password: 'password', role: 1)
      merchant_3 = User.create!(username: 'nothappy', street: '432 main st', city: 'stephen', state: 'CO', zip_code: 80126, email: '3tester@bob.net', password: 'password', role: 1, enabled: 1)
      user = User.create!(username: 'mehhappy', street: '432 main st', city: 'stephen', state: 'CO', zip_code: 80126, email: '4tester@bob.net', password: 'password', role: 0, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit items_path

      click_link 'Merchants'

      expect(current_path).to eq(merchants_path)

      within "#merchant-#{merchant_1.id}" do
        expect(page).to have_link("Name: supperhappy")
        expect(page).to have_content("City: steve")
        expect(page).to have_content("State: CO")
        expect(page).to have_button("Disable")
      end

      within "#merchant-#{merchant_3.id}" do
        expect(page).to have_link("Name: nothappy")
        expect(page).to have_content("City: stephen")
        expect(page).to have_content("State: CO")
        expect(page).to have_button("Enable")
      end
      expect(page).to_not have_content("mehhappy")

      click_link "Name: supperhappy"

      expect(current_path).to eq(admin_merchant_path(merchant_1))
    end
  end
end
