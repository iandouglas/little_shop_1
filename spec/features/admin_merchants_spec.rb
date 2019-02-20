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

    it 'allows me to fulfill items on behalf of a merchant' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 30, price: 9.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 1, price: 3.75, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 2)
      OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
      OrderItem.create(item_id: item_3.id, order_id: order_1.id, fulfilled: 0, current_price: 3.75, quantity: 100)
      change = OrderItem.create(item_id: item_4.id, order_id: order_1.id, fulfilled: 0, current_price: 80, quantity: 5)

      visit admin_merchant_order_path(merchant.id, order_1.id)

      expect(page).to have_content("Order: #{order_1.id}")
      within "#item-#{item_1.id}" do
        expect(page).to have_button('Fulfill Item')
        expect(page).to_not have_content('Cannot Fulfill')
        expect(page).to_not have_content('Item Fulfilled')
      end
      within "#item-#{item_2.id}" do
        expect(page).to_not have_button('Fulfill Item')
        expect(page).to_not have_content('Cannot Fulfill')
        expect(page).to have_content('Item Fulfilled')
      end
      within "#item-#{item_3.id}" do
        expect(page).to_not have_button('Fulfill Item')
        expect(page).to have_content('Cannot Fulfill')
        expect(page).to_not have_content('Item Fulfilled')
      end
      within "#item-#{item_4.id}" do
        expect(page).to have_button('Fulfill Item')
        click_button 'Fulfill Item'
      end
      expect(current_path).to eq(admin_merchant_order_path(merchant.id, order_1))
      expect(page).to have_content("You have successfully fulfilled markers for this order.")

      within "#item-#{item_4.id}" do
        expect(page).to_not have_button('Fulfill Item')
        expect(page).to have_content('Item Fulfilled')
      end
    end
  end
end
