require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do

  describe 'when I visit the merchant index' do
    it 'shows top three merchants that sold the most items by price and qty' do
      user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
      user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
      user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
      user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
      merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "122@54321", password: "password", role: 1, enabled: 0)
      merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
      merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
      merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
      merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
      order_1 = Order.create!(user_id: user_1.id, status: 1)
      order_2 = Order.create!(user_id: user_2.id, status: 1)
      order_3 = Order.create!(user_id: user_2.id, status: 1)
      order_4 = Order.create!(user_id: user_3.id, status: 1)
      order_5 = Order.create!(user_id: user_3.id, status: 1)
      order_6 = Order.create!(user_id: user_3.id, status: 1)
      order_7 = Order.create!(user_id: user_1.id, status: 1)
      order_8 = Order.create!(user_id: user_4.id, status: 1)
      item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
      item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
      item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
      item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
      item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
      OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
      OrderItem.create!(item_id: item_5.id, order_id: order_5.id, fulfilled: 1, current_price: 50.00, quantity: 16)
      OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 13)
      OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_6.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_7.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_8.id, fulfilled: 1, current_price: 100.00, quantity: 20)

      visit merchants_path
      within '.statistics' do
        within '#most-sold' do
          expect(page).to have_content("#{merchant_3.username}- 100")
          expect(page).to have_content("#{merchant_2.username}- $1000.00")
          expect(page).to have_content("#{merchant_5.username}- $800.00")
        end
      end
    end

    it 'shows the top three merchants with the fastest fulfillment times' do
      user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
      user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
      user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
      user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
      merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "122@54321", password: "password", role: 1, enabled: 0)
      merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
      merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
      merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
      merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
      order_1 = Order.create!(user_id: user_1.id, status: 1)
      order_2 = Order.create!(user_id: user_2.id, status: 1)
      order_3 = Order.create!(user_id: user_2.id, status: 1)
      order_4 = Order.create!(user_id: user_3.id, status: 1)
      order_5 = Order.create!(user_id: user_3.id, status: 1)
      order_6 = Order.create!(user_id: user_3.id, status: 1)
      order_7 = Order.create!(user_id: user_1.id, status: 1)
      order_8 = Order.create!(user_id: user_4.id, status: 1)
      item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
      item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
      item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
      item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
      item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
      OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
      OrderItem.create!(item_id: item_5.id, order_id: order_5.id, fulfilled: 1, current_price: 50.00, quantity: 16)
      OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 13)
      OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_6.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_7.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_8.id, fulfilled: 1, current_price: 100.00, quantity: 20)

      visit merchants_path
      within '.statistics' do
        within '#fastest-fulfillers' do
          expect(page).to have_content("Merchant: bob")
          expect(page).to have_content("Merchant: steve")
          expect(page).to have_content("Merchant: cappy")
        end
        within '#slowest-fulfillers' do
          expect(page).to have_content("Mercahnt: andre")
          expect(page).to have_content("Mercahnt: jobby")
          expect(page).to have_content("Mercahnt: cappy")
        end
      end
    end

    it 'shows the top three states with the highest number of orders shipped to' do
      user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
      user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
      user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
      user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
      merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "122@54321", password: "password", role: 1, enabled: 0)
      merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
      merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
      merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
      merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
      order_1 = Order.create!(user_id: user_1.id, status: 1)
      order_2 = Order.create!(user_id: user_2.id, status: 1)
      order_3 = Order.create!(user_id: user_2.id, status: 1)
      order_4 = Order.create!(user_id: user_3.id, status: 1)
      order_5 = Order.create!(user_id: user_3.id, status: 1)
      order_6 = Order.create!(user_id: user_3.id, status: 1)
      order_7 = Order.create!(user_id: user_1.id, status: 1)
      order_8 = Order.create!(user_id: user_4.id, status: 1)
      item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
      item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
      item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
      item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
      item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
      OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
      OrderItem.create!(item_id: item_5.id, order_id: order_5.id, fulfilled: 1, current_price: 50.00, quantity: 16)
      OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 13)
      OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_6.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_7.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_8.id, fulfilled: 1, current_price: 100.00, quantity: 20)

      visit merchants_path
      within '.statistics' do
        within '#top-states' do
          expect(page).to have_content("State: CO, Orders: 3")
          expect(page).to have_content("State: CA, Orders: 2")
          expect(page).to have_content("State: MA, Orders: 2")
        end
      end
    end

    it 'shows the top three cities with the highest number of orders shipped to' do
      user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
      user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
      user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
      user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
      merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "122@54321", password: "password", role: 1, enabled: 0)
      merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
      merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
      merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
      merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
      order_1 = Order.create!(user_id: user_1.id, status: 1)
      order_2 = Order.create!(user_id: user_2.id, status: 1)
      order_3 = Order.create!(user_id: user_2.id, status: 1)
      order_4 = Order.create!(user_id: user_3.id, status: 1)
      order_5 = Order.create!(user_id: user_3.id, status: 1)
      order_6 = Order.create!(user_id: user_3.id, status: 1)
      order_7 = Order.create!(user_id: user_1.id, status: 1)
      order_8 = Order.create!(user_id: user_4.id, status: 1)
      item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
      item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
      item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
      item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
      item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
      OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
      OrderItem.create!(item_id: item_5.id, order_id: order_5.id, fulfilled: 1, current_price: 50.00, quantity: 16)
      OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 13)
      OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_6.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_7.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_8.id, fulfilled: 1, current_price: 100.00, quantity: 20)

      visit merchants_path
      within '.statistics' do
        within '#top-cities' do
          expect(page).to have_content("City: candle, State: CO, Orders: 3")
          expect(page).to have_content("City: candle, State: CA, Orders: 2")
          expect(page).to have_content("City: bob, State: MA, Orders: 2")
        end
      end
    end

    it 'shows the top three largest orders by quantity of items shipped with their qty' do
      user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
      user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
      user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
      user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
      merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "122@54321", password: "password", role: 1, enabled: 0)
      merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
      merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
      merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
      merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
      order_1 = Order.create!(user_id: user_1.id, status: 1)
      order_2 = Order.create!(user_id: user_2.id, status: 1)
      order_3 = Order.create!(user_id: user_2.id, status: 1)
      order_4 = Order.create!(user_id: user_3.id, status: 1)
      order_5 = Order.create!(user_id: user_3.id, status: 1)
      order_6 = Order.create!(user_id: user_3.id, status: 1)
      order_7 = Order.create!(user_id: user_1.id, status: 1)
      order_8 = Order.create!(user_id: user_4.id, status: 1)
      item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
      item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
      item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
      item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
      item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
      OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
      OrderItem.create!(item_id: item_5.id, order_id: order_5.id, fulfilled: 1, current_price: 50.00, quantity: 16)
      OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 13)
      OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_6.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_7.id, fulfilled: 1, current_price: 100.00, quantity: 5)
      OrderItem.create!(item_id: item_3.id, order_id: order_8.id, fulfilled: 1, current_price: 100.00, quantity: 20)

      visit merchants_path
      within '.statistics' do
        within '#largest-orders' do
          expect(page).to have_content("Order: #{order_8.id}, Count: 20")
          expect(page).to have_content("Order: #{order_5.id}, Count: 16")
          expect(page).to have_content("Order: #{order_1.id}, Count: 13")
        end
      end
    end
  end
end
