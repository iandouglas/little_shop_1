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
end
