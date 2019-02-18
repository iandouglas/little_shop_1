require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do

  it 'lets an admin view a user showpage' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_path(user)

    expect(current_path).to eq(admin_user_path(user))
    expect(page).to have_content("Welcome test!")
    expect(page).to have_content("Name: #{user.username}")
    expect(page).to have_content("Street Address: #{user.street}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip Code: #{user.zip_code}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Edit Profile")
  end

  it 'lets an admin edit a users information' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_path(user)

    click_link 'Edit Profile'

    expect(current_path).to eq(edit_profile_path)

    fill_in 'City', with: 'happy steve'
    click_button 'Save Changes'

    expect expect(current_path).to eq(admin_user_path(user))
    expect(page).to have_content("City: happy steve")
  end

  it 'lets an admin see a users orders' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    merchant = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'tester@bob.net', password: 'password', role: 1)
    item = Item.create(name: "blah", description: "meh of meh", quantity: 200, price: 2.50, thumbnail: "haha", user_id: merchant.id)
    # order = Order.create(user_id: user.id)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_path(user)

    expect(page).to have_content("See happy's orders")
    expect(page).to have_content("Upgrade happy to a Merchant")
  end

  it 'lets an admin upgrade a user to a merchant' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 0)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_path(user)

    click_link "Upgrade happy to a Merchant"

    expect(current_path).to eq(admin_merchant_path(user))
    expect(page).to have_content("happy is now a merchant")
    expect(User.last.role).to eq('merchant')

    visit admin_user_path(user)

    expect(current_path).to eq(admin_merchant_path(user))

    click_link 'Logout'
    click_link 'Log In'
    fill_in 'Email', with: 'te@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq(dashboard_path)
  end

  it 'lets an admin downgrade a merchant to a regular user' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    merchant = User.create!(username: 'happy', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: '1test@bob.net', password: 'password', role: 1)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_merchant_path(merchant)
    # save_and_open_page

    click_link "Downgrade"

    expect(current_path).to eq(admin_user_path(merchant))
    expect(page).to have_content("happy is now a user")
    expect(User.last.role).to eq('user')

    click_link 'Logout'
    click_link 'Log In'
    fill_in 'Email', with: '1test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq(profile_path)
  end

  it 'when a merchant is downgraded to user, items for that merchant are disabled' do
    admin = User.create(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    merchant = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: '1test@bob.net', password: 'password', role: 1)

    item_1 = Item.create!(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: merchant.id)
    item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: merchant.id)
    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_merchant_path(merchant)

    expect(item_1.enabled?).to be true
    expect(item_2.enabled?).to be true

    click_link "Downgrade"

    expect(User.last.role).to eq('user')

    disabled_item_1 = Item.find(item_1.id)
    disabled_item_2 = Item.find(item_2.id)

    expect(disabled_item_1.disabled?).to be true
    expect(disabled_item_2.disabled?).to be true


  end
end
