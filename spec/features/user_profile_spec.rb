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

  it "can edit the information for that user" do
    user = User.create(username: 'bob', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'bob@bob.net', password: 'password')

    visit root_path

    click_link 'Log In'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button 'Sign In'

    click_link "Edit Profile"

    expect(current_path).to eq(edit_profile_path)

    fill_in 'Username', with: 'bob'
    fill_in 'Street', with: '555 first st.'
    fill_in 'City', with: 'Boston'
    fill_in 'State', with: 'MA'
    fill_in 'Zip code', with: "02018"
    fill_in 'Email', with: 'bob@bob.net'

    first_pass = User.last.password_digest
    # save_and_open_page
    click_on 'Save Changes'

    expect(current_path).to eq(profile_path)


    expect(page).to have_content("Street Address: 555 first st.")
    expect(page).to have_content("City: Boston")
    expect(page).to have_content("State: MA")
    expect(page).to have_content("Zip Code: 02018")
    expect(User.last.password_digest).to eq(first_pass)

    visit profile_path

    first_pass = User.last.password_digest
    click_link 'Edit Profile'
    fill_in 'Password', with: "dave"
    # save_and_open_page
    fill_in 'Confirm password', with: "dave"
    click_on 'Save Changes'

    expect(first_pass).to_not eq(User.last.password_digest)
    expect(page).to have_content('City: Boston')

    click_link 'Logout'
    click_link 'Log In'

    click_link 'Log In'

    fill_in :email, with: user.email
    fill_in :password, with: 'dave'

    click_button 'Sign In'

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("City: Boston")
  end


end

#user story 17
# As a registered user
# When I visit my own profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data
