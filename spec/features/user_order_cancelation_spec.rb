require 'rails_helper'

RSpec.describe 'as a registered user' do
  describe 'in an order showpage' do
    it 'it has a button to cancel order' do
      user = User.create!(username: 'unhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1test@bob.net', password: 'password', role: 0)
      order_1 = user.orders.create(user_id: user.id)
      order_2 = user.orders.create(user_id: user.id, status: 1)
      order_3 = user.orders.create(user_id: user.id, status: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_order_path(order_1)
      expect(page).to have_button("Cancel Order")

      visit profile_order_path(order_2)
      expect(page).to_not have_button("Cancel Order")

      visit profile_order_path(order_3)
      expect(page).to_not have_button("Cancel Order")
    end
  end

  describe 'when I press the cancel order button' do
    it 'cancels an order when I press the button' do
      user = User.create!(username: 'unhappy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: '1test@bob.net', password: 'password', role: 0)
      merchant = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      order_1 = user.orders.create(user_id: user.id)
      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant)
      item_2 = Item.create(name: 'pot_2', description:'a small pot for plants', quantity: 20, price: 20.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant)
      item_3 = Item.create(name: 'pot_3', description:'a small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant)
      OrderItem.create(item_id: item_1.id, order_id: order_1.id, quantity: 3, current_price: 2.50)
      OrderItem.create(item_id: item_2.id, order_id: order_1.id, quantity: 3, current_price: 20.00, fulfilled: 1)
      OrderItem.create(item_id: item_3.id, order_id: order_1.id, quantity: 3, current_price: 3.00, fulfilled: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_order_path(order_1)

      click_button 'Cancel Order'
      orderitem = OrderItem.last.fulfilled
      item_quantity_1 = Item.find(item_2.id).quantity
      item_quantity_2 = Item.find(item_3.id).quantity

      expect(current_path).to eq(profile_order_path(order_1))
      expect(page).to_not have_button('Cancel Order')
      expect(page).to have_content("This order has been cancelled")
      expect(page).to have_content("Status: cancelled")
      expect(orderitem).to eq('unfulfilled')
      expect(item_quantity_1).to eq(23)
      expect(item_quantity_2).to eq(23)
    end
  end
end
