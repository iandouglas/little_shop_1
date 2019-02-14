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
    user = User.create(username: 'happy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
    merchant = User.create(username: 'bobith', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
    item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
    item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
    item_3 = Item.create(name: 'fvijodv', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
    order_1 = Order.create(user_id: user.id)
    order_2 = Order.create(user_id: user.id)
    order_item_1 = OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.00, quantity: 2)
    OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.50, quantity: 3)
    OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 0, current_price: 10.0, quantity: 4)

    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_user_path(user)

    expect(page).to have_content("See happy's orders")
    expect(page).to have_content("Upgrade happy to a Merchant")

    click_link "See happy's orders"

    expect(current_path).to eq(admin_user_orders_path(user))

    within "#order-#{order_1.id}" do
      expect(page).to have_link("ID: #{order_1.id}")
      expect(page).to have_content("Order Placed: #{order_1.created_at}")
      expect(page).to have_content("Last Updated: #{order_1.updated_at}")
      expect(page).to have_content("Current Status: #{order_1.status}")
      expect(page).to have_content("Total Items: #{order_1.total_item_quantity}")
      expect(page).to have_content("Grand Total: $12.50")
    end
  end

  it 'lets an admin see a users order show page' do
    admin = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 2)
    user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
    merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
    item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiZmf7V4sjgAhUe3YMKHZlsDyYQjRx6BAgBEAU&url=https%3A%2F%2Fwww.homedepot.com%2Fp%2FPennington-8-in-Terra-Cotta-Clay-Pot-100043015%2F100333339&psig=AOvVaw0wGUQTqb1vGanpmydM3DY4&ust=1550699158284985", user_id: merchant.id)
    item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.50, thumbnail: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiZmf7V4sjgAhUe3YMKHZlsDyYQjRx6BAgBEAU&url=https%3A%2F%2Fwww.homedepot.com%2Fp%2FPennington-8-in-Terra-Cotta-Clay-Pot-100043015%2F100333339&psig=AOvVaw0wGUQTqb1vGanpmydM3DY4&ust=1550699158284985", user_id: merchant.id)
    item_3 = Item.create(name: 'fvijodv', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiZmf7V4sjgAhUe3YMKHZlsDyYQjRx6BAgBEAU&url=https%3A%2F%2Fwww.homedepot.com%2Fp%2FPennington-8-in-Terra-Cotta-Clay-Pot-100043015%2F100333339&psig=AOvVaw0wGUQTqb1vGanpmydM3DY4&ust=1550699158284985", user_id: merchant.id)
    order_1 = Order.create(user_id: user.id)
    order_2 = Order.create(user_id: user.id)
    order_item_1 = OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.0, quantity: 2)
    order_item_2 = OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.50, quantity: 3)

    visit login_path
    fill_in 'Email', with: 'test@bob.net'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit admin_order_path(user)

    expect(page).to have_content("ID: #{order_1.id}")
    expect(page).to have_content("Order Placed: #{order_1.created_at}")
    expect(page).to have_content("Last Updated: #{order_1.updated_at}")
    expect(page).to have_content("Current Status: pending")

    within ".item-#{item_1.id}" do
      expect(page).to have_content("#{item_1.name}")
      expect(page).to have_content("Description: #{item_1.description}")
      expect(page).to have_content("Quantity: #{item_1.quantity}")
      expect(page).to have_content("Price: $#{item_1.price}")
      expect(page).to have_content("Sub Total: $#{order_item_1.current_price}")
    end
    within ".item-#{item_2.id}" do
      expect(page).to have_content("#{item_2.name}")
      expect(page).to have_content("Description: #{item_2.description}")
      expect(page).to have_content("Quantity: #{item_2.quantity}")
      expect(page).to have_content("Price: $#{item_2.price}")
    end
    expect(page).to have_content("Total Items: #{order_1.total_item_quantity}")
    expect(page).to have_content("Grand Total: $#{order_1.total_item_price}")
    expect(page).to_not have_content("ID: #{order_2.id}")
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
