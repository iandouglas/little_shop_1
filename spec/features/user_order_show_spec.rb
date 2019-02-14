require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do

  describe ' When a user visits an order show page' do
    it 'Shows information about the order' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
      item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
      item_3 = Item.create(name: 'fvijodv', description: "oreijvioe", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      order_2 = Order.create(user_id: user.id)
      order_item_1 = OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.0, quantity: 2)
      OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.5, quantity: 3)
      OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 0, current_price: 10.0, quantity: 4)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_orders_path
      click_link "ID: #{order_1.id}"

      expect(current_path).to eq(profile_order_path(order_1))
      expect(page).to have_content("ID: #{order_1.id}")
      expect(page).to have_content("Order Placed: #{order_1.created_at}")
      expect(page).to have_content("Last Updated: #{order_1.updated_at}")
      expect(page).to have_content("Current Status: #{order_1.status}")
      within ".item-#{item_1}" do
        expect(page).to have_content("Name: #{item_1.name}")
        expect(page).to have_content("Description: #{item_1.description}")
        expect(page).to have_content("Quantity: #{order_item_1.quantity}")
        expect(page).to have_content("Price: #{item_1.price}")
        expect(page).to have_content("Sub Total: #{order_item_1.current_price}")
        # expect(page).to xpath("thumbnail: #{item_1.thumbnail}")
      end
      expect(page).to have_content("Total Items: #{order_1.total_item_quantity}")
      expect(page).to have_content("Grand Total: #{order_1.total_item_price}")
    end
  end
end
