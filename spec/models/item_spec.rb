require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :price}
    it {should validate_presence_of :thumbnail}
    it {should validate_presence_of :enabled}
    it {should validate_presence_of :user_id}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many :orders}
  end

  describe 'instance methods' do
    describe '.order_quantity' do
      it 'should show the quantity of items in an order' do
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

        item_count = item_1.order_quantity(order_1.id)

        expect(item_count).to eq(2)
      end
    end
    describe '.quantity_price' do
      it 'should show the total price of that item in order' do
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

        item_total_price = item_1.quantity_price(order_1.id)

        expect(item_total_price).to eq(5.0)
      end
    end

    describe '.disable_item' do
      it 'should change item from enabled to disabled' do
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)

        item_1.disable_item

        expect(item_1.enabled?).to be false
      end
    end
  end

  describe 'class methods' do
    describe '.for_merchant' do
      it 'returns items with the total quantity sold for each item for a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order_1 = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 3)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 3)

        result = Item.for_merchant(merchant.id)

        expect(result.first.first).to eq('meh')
        expect(result.first.last).to eq(5)
      end
    end
  end
end
