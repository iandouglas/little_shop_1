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

  describe 'class methods' do
    describe '.for_merchant' do
      it 'returns items with the total quantity sold for each item for a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 3)

        result = OrderItem.for_merchant(merchant.id)

        expect(result.first.item.name).to eq('meh')
        expect(result.first.quantity).to eq(5)
      end
    end
  end
end
