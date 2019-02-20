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
    describe '.fulfill_item' do
      it 'fulfills all items through the order item relation' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'merch', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
        order = Order.create(user_id: user.id)
        orderi = OrderItem.create(item_id: item.id, order_id: order.id, fulfilled: 0, current_price: 2.50, quantity: 2)

        OrderItem.fulfill_item(order.id, item.id)
        item = OrderItem.find(orderi.id)

        expect(item.fulfilled?).to eq(true)
      end
    end
  end
end
