require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  describe 'a merchant can enable/disable items' do
    it 'can disable item' do
      user = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: '1test@bob.net', password: 'password', role: 1)
      item_1 = Item.create!(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: user.id)
      item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: user.id)
      order_1 = Order.create(user_id: user.id)
      OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.0, quantity: 2)
      OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.50, quantity: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_orders_path(order_1)

      expect(item_1.enabled?).to be true

      within "#item-#{item_1.id}" do
        click_button "Disable"
      end

      expect(Item.find(item_1.id).disabled?).to be true
      expect(current_path).to eq(dashboard_orders_path(order_1))
      expect(page).to have_content("#{item_1.name} is now available for sale")
    end

    it 'can enable item' do
      user = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: '1test@bob.net', password: 'password', role: 1)
      item_1 = Item.create!(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: user.id, enabled: 1)
      item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/71VGZezvsGL._SX466_.jpg', user_id: user.id)
      order_1 = Order.create(user_id: user.id)
      OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 5.0, quantity: 2)
      OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 0, current_price: 7.50, quantity: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_items_path

      expect(item_1.disabled?).to be true

      within "#item-#{item_1.id}" do
        click_button "Enable"
      end

      expect(Item.find(item_1.id).enabled?).to be true
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{item_1.name} is no longer for sale")
    end
  end
end
