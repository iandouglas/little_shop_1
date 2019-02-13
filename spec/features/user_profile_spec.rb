require 'rails_helper'

RSpec.describe 'as registered user', type: :feature do
  it "when user vistis profile page" do
    user = User.create!(username: 'bob', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'bob@bob.net', password: 'password')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    expect(page).to have_content("Name: #{user.username}")
    expect(page).to have_content("Street Address: #{user.street}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip Code: #{user.zip_code}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to_not have_content(user.password)
    expect(page).to have_link("Edit Profile")
  end


end

#user story 17
# As a registered user
# When I visit my own profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data
