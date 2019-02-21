require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe 'validations' do
    it {should validate_presence_of :item_id}
    it {should validate_presence_of :order_id}
    it {should validate_presence_of :fulfilled}
    it {should validate_presence_of :current_price}
    it {should validate_presence_of :quantity}
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe '.instance method' do
    describe 'after_save' do
      describe 'update_order' do
        it "should check the order its related to to update pending/shipped status" do
          user = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
          merchant = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
          item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
          item_2 = Item.create!(name: 'vfjkdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
          item_3 = Item.create!(name: 'vfjkfafdnj', description: "fjndkjknk", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
          order = Order.create!(user_id: user.id)
          fulfilled = OrderItem.create!(item_id: item_1.id, order_id: order.id, fulfilled: 1, current_price: 5.0, quantity: 2)
          unfulfilled = OrderItem.create!(item_id: item_2.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)
          unfulfilled_2 = OrderItem.create!(item_id: item_3.id, order_id: order.id, fulfilled: 0, current_price: 7.5, quantity: 3)

          unfulfilled.update(fulfilled: 1)
          unfulfilled.save
          order_1 = Order.find(order.id)
          expect(order_1.status).to eq('pending')
          unfulfilled_2.update(fulfilled: 1)
          unfulfilled.save
          order_2 = Order.find(order.id)
          expect(order_2.status).to eq('shipped')
        end
      end
    end
  end
end
