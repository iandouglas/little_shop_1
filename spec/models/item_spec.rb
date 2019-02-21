require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :price}
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

    describe '.average_fulfilled_time' do
      it 'returns the average fulfillment time for an item' do
        merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)

        user = User.create(username: 'Mary', street: "8765", city: "San Francisco", state: "CA", zip_code: 00000, email: "mary@54321", password: "password", role: 0, enabled: 0)

        item_1 = Item.create!(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)

        order_1 = Order.create(user: user)
        order_2 = Order.create(user: user)
        order_3 = Order.create(user: user)

        OrderItem.create(item: item_1, order: order_1, fulfilled: 1, current_price: 5.0, quantity: 5, created_at: 3.days.ago)
        OrderItem.create(item: item_1, order: order_2, fulfilled: 1, current_price: 7.50, quantity: 8, created_at: 2.days.ago)
        OrderItem.create(item: item_1, order: order_3, fulfilled: 1, current_price: 15.0, quantity: 10, created_at: 6.days.ago)

        expect(item_1.average_fulfilled_time).to eq("3 days 16 hours")
      end
    end
  end

  describe 'class methods' do
    describe 'five_most_popular' do
      it 'should find the 5 most popular and 5 least items by fulfilled' do
        merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

        user = User.create(username: 'Mary', street: "8765", city: "San Francisco", state: "CA", zip_code: 00000, email: "mary@54321", password: "password", role: 0, enabled: 0)

        item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
        item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
        item_3 = Item.create(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)
        item_4 = Item.create(name: 'pot_4', description:'this is also a small pot for plants', quantity: 5, price: 6.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_2)
        item_5 = Item.create(name: 'pot_5', description:'this is also a small pot for plants', quantity: 12, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_1)
        item_6 = Item.create(name: 'pot_6', description:'this is also a small pot for plants', quantity: 7, price: 15.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_2)
        item_7 = Item.create(name: 'pot_7', description:'this is also a small pot for plants', quantity: 20, price: 10.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_1)
        item_8 = Item.create(name: 'pot_8', description:'this is also a small pot for plants', quantity: 18, price: 23.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_2)
        item_9 = Item.create(name: 'pot_9', description:'this is also a small pot for plants', quantity: 44, price: 19.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_1)
        item_10 = Item.create(name: 'pot_10', description:'this is also a small pot for plants', quantity: 11, price: 8.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_2)
        item_11 = Item.create(name: 'pot_11', description:'this is also a small pot for plants', quantity: 3, price: 22.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 0, user: merchant_1)

        order_1 = Order.create(user: user)
        order_2 = Order.create(user: user)
        order_3 = Order.create(user: user)

        OrderItem.create(item: item_1, order: order_1, fulfilled: 1, current_price: 5.0, quantity: 5)
        OrderItem.create(item: item_2, order: order_1, fulfilled: 1, current_price: 7.50, quantity: 8)
        OrderItem.create(item: item_3, order: order_1, fulfilled: 1, current_price: 15.0, quantity: 10)
        OrderItem.create(item: item_4, order: order_1, fulfilled: 1, current_price: 18.0, quantity: 12)
        OrderItem.create(item: item_5, order: order_1, fulfilled: 1, current_price: 100.0, quantity: 14)
        OrderItem.create(item: item_6, order: order_1, fulfilled: 1, current_price: 35.0, quantity: 16)
        OrderItem.create(item: item_7, order: order_1, fulfilled: 1, current_price: 150.0, quantity: 18)
        OrderItem.create(item: item_10, order: order_1, fulfilled: 1, current_price: 15.0, quantity: 14)
        OrderItem.create(item: item_8, order: order_2, fulfilled: 1, current_price: 60.0, quantity: 20)
        OrderItem.create(item: item_9, order: order_2, fulfilled: 1, current_price: 73.0, quantity: 22)
        OrderItem.create(item: item_10, order: order_2, fulfilled: 1, current_price: 15.0, quantity: 10)
        OrderItem.create(item: item_11, order: order_3, fulfilled: 0, current_price: 89.0, quantity: 30)

        expect(Item.five_most_popular).to eq([item_10,item_9,item_8,item_7,item_6])
        expect(Item.five_least_popular).to eq([item_1,item_2,item_4,item_5,item_6])
      end
    end

    describe 'unsold_items' do
      it 'return items that have not been sold' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'fvijodv', description: "oreijvioe", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.0, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.5, quantity: 3)

        result = Item.unsold_items([item_1, item_2, item_3])

        expect(result).to eq([item_3])
      end
    end
  end
end
