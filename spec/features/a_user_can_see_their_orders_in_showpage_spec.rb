require 'rails_helper'


RSpec.describe 'as a registered user', type: :feature do
  describe 'when a user is logged in' do
    it 'in their showpage they see an orders link' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_link('View Orders')
    end

    it 'in the nav a user sees a link to their orders page'

  end


end
