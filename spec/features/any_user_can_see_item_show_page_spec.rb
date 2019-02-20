require 'rails_helper'

RSpec.describe "When I visit an item's show page from the items catalog", type: :feature do
  describe 'as visitor' do
    it 'lets me see all information for this item' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)

      user = User.create(username: 'Mary', street: "8765", city: "San Francisco", state: "CA", zip_code: 00000, email: "mary@54321", password: "password", role: 0, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)

      order_1 = Order.create(user: user)
      order_2 = Order.create(user: user)
      order_3 = Order.create(user: user)

      OrderItem.create(item: item_1, order: order_1, fulfilled: 1, current_price: 5.0, quantity: 5, created_at: 3.days.ago)
      OrderItem.create(item: item_1, order: order_2, fulfilled: 1, current_price: 7.50, quantity: 8, created_at: 2.days.ago)
      OrderItem.create(item: item_1, order: order_3, fulfilled: 1, current_price: 15.0, quantity: 10, created_at: 6.days.ago)

      visit item_path(item_1)

      expect(page).to have_content( "#{item_1.name}" )
      expect(page).to have_content( "Description: #{item_1.description}" )
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(item_1.thumbnail)}')]")
      expect(page).to have_content( "Merchant: #{item_1.user.username}" )
      expect(page).to have_content( "Items available: #{item_1.quantity}" )
      expect(page).to have_content( "Unit Price: #{item_1.price}" )
      expect(page).to have_content( "Average fulfillment time: #{item_1.average_fulfilled_time}" )

      expect(page).to_not have_content( "#{item_2.name}" )
      expect(page).to_not have_content( "#{item_2.description}" )
    end
  end
  describe 'as a registered user' do
    it 'lets me see all information for this item' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)

      user = User.create(username: 'Mary', street: "8765", city: "San Francisco", state: "CA", zip_code: 00000, email: "mary@54321", password: "password", role: 0, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)

      order_1 = Order.create(user: user)
      order_2 = Order.create(user: user)
      order_3 = Order.create(user: user)

      OrderItem.create(item: item_1, order: order_1, fulfilled: 1, current_price: 5.0, quantity: 5, created_at: 3.days.ago)
      OrderItem.create(item: item_1, order: order_2, fulfilled: 1, current_price: 7.50, quantity: 8, created_at: 2.days.ago)
      OrderItem.create(item: item_1, order: order_3, fulfilled: 1, current_price: 15.0, quantity: 10, created_at: 6.days.ago)

      visit item_path(item_1)

      expect(page).to have_content( "#{item_1.name}" )
      expect(page).to have_content( "Description: #{item_1.description}" )
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(item_1.thumbnail)}')]")
      expect(page).to have_content( "Merchant: #{item_1.user.username}" )
      expect(page).to have_content( "Items available: #{item_1.quantity}" )
      expect(page).to have_content( "Unit Price: #{item_1.price}" )
      expect(page).to have_content( "Average fulfillment time: #{item_1.average_fulfilled_time}" )

      expect(page).to_not have_content( "#{item_2.name}" )
      expect(page).to_not have_content( "#{item_2.description}" )
    end
  end
end
