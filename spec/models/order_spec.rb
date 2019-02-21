require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'validations' do
  end

  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'instance methods' do
    describe '.total_item_quantity' do
      it 'should total the number of items in an order' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        order = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 5.0, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)

        total_items = order.total_item_quantity

        expect(total_items).to eq(5)
      end
    end

    describe '.total_item_price' do
      it 'should total the price of items in an order' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        order = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 5.0, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)

        total_price = order.total_item_price

        expect(total_price).to eq(12.5)
      end
    end

    describe '.total_item_quantity_for_merchant' do
      it 'should total the number of items in an order for a merchants items' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'boby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@5421", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 5.0, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)

        total_items = order.total_item_quantity_for_merchant(merchant.id)

        expect(total_items).to eq(2)
      end
    end

    describe '.total_item_price_for_merchant' do
      it 'should total the price of items in an order for a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@5321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 5.0, quantity: 5)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)

        total_price = order.total_item_price_for_merchant(merchant.id)

        expect(total_price).to eq(25.0)
      end
    end

    describe '.items_for_merchant' do
      it 'should return items in order for specific merchant and current_price and quantity' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 2.5, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 2.5, quantity: 3)

        result = order.items_for_merchant(merchant)

        expect(result.length).to eq(1)
        expect(result.first.name).to eq('meh')
        expect(result.first.thumbnail).to eq('steve.jpg')
        expect(result.first.current_price).to eq(2.5)
        expect(result.first.orderquan).to eq(2)
        expect(result.first.fulfilled?).to eq(false)
      end
    end
  end

  describe 'class methods' do
    describe 'for_merchant' do
      it 'should return me only orders that have items I sell in them' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'bob2', street: "12342", city: "bob2", state: "bobby2", zip_code: 12342, email: "12@54322", password: "password2", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order.id, fulfilled: 0, current_price: 5.0, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)
        OrderItem.create(item_id: item_2.id, order_id: order_2.id, fulfilled: 0, current_price: 7.5, quantity: 3)



        expect(Order.for_merchant(merchant.id)).to eq([order])
      end
    end
    describe 'self.top_biggest_orders' do
      it 'shows the top three orders by qty of items shipped' do
        user_1 = User.create!(username: 'user', street: "1234", city: "bob", state: "MA", zip_code: 12345, email: "a@54321", password: "password", role: 0, enabled: 0)
        user_2 = User.create!(username: 'user', street: "1234", city: "candle", state: "CA", zip_code: 12345, email: "s12345@54321", password: "password", role: 0, enabled: 0)
        user_3 = User.create!(username: 'user', street: "1234", city: "candle", state: "CO", zip_code: 12345, email: "d12345@54321", password: "password", role: 0, enabled: 0)
        user_4 = User.create!(username: 'user', street: "1234", city: "carber", state: "bobby", zip_code: 12345, email: "f12345@54321", password: "password", role: 0, enabled: 0)
        merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
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

        result = Order.top_biggest_orders

        expect(result.first.id).to eq(order_8.id)
        expect(result.first.item_count).to eq(20)
        expect(result.second.id).to eq(order_5.id)
        expect(result.second.item_count).to eq(16)
        expect(result.third.id).to eq(order_1.id)
        expect(result.third.item_count).to eq(13)
      end
    end
  end
end
