require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'validations' do
  end

  describe 'realationships' do
    it {should belong_to :user}
  end

  describe 'instance methods' do
    describe '.total_item_quantity' do
      it 'should total the number of items in an order' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
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
      it 'should total the price of items in an order'
    end


  end
end
