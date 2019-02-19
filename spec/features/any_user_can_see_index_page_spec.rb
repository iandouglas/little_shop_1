require 'rails_helper'

RSpec.describe 'When I visit the items catalog', type: :feature do
  describe 'as visitor' do
    it 'lets me see all items in the system except disabled ones' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)

      visit items_path

      expect(page).to have_content("Items Catalog")

      within "#item-#{item_1.id}" do
        expect(page).to have_content("pot_1")
        expect(page).to have_link("#{item_1.name}", href: item_path(item_1))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 30")
        expect(page).to have_content("Price: $2.50")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("pot_2")
        expect(page).to have_link("#{item_2.name}", href: item_path(item_2))
      # expect(page).to have_link("#{item_2.thumbnail}", href: item_path(item_2))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 20")
        expect(page).to have_content("Price: $3.00")
      end

      expect(page).not_to have_content("pot_3")
      expect(page).not_to have_link("#{item_3.name}", href: item_path(item_3))
    end
  end

  describe 'as a registered user' do
    it 'lets me see all items in the system except disabled ones' do
      user = User.create(username: 'Mary', street: "8765", city: "San Francisco", state: "CA", zip_code: 00000, email: "mary@54321", password: "password", role: 0, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)


      visit items_path

      expect(page).to have_content("Items Catalog")

      within "#item-#{item_1.id}" do
        expect(page).to have_content("pot_1")
        expect(page).to have_link("#{item_1.name}", href: item_path(item_1))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 30")
        expect(page).to have_content("Price: $2.50")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("pot_2")
        expect(page).to have_link("#{item_2.name}", href: item_path(item_2))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 20")
        expect(page).to have_content("Price: $3.00")
      end

      expect(page).not_to have_content("pot_3")
      expect(page).not_to have_link("#{item_3.name}", href: item_path(item_3))
    end
  end

  describe 'as a merchant' do
    it 'lets me see all items in the system except disabled ones' do
      merchant = User.create(username: 'Josh', street: "5665", city: "San Francisco", state: "CA", zip_code: 00000, email: "josh@54321", password: "password", role: 1, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)


      visit items_path

      expect(page).to have_content("Items Catalog")

      within "#item-#{item_1.id}" do
        expect(page).to have_content("pot_1")
        expect(page).to have_link("#{item_1.name}", href: item_path(item_1))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 30")
        expect(page).to have_content("Price: $2.50")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("pot_2")
        expect(page).to have_link("#{item_2.name}", href: item_path(item_2))
      # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 20")
        expect(page).to have_content("Price: $3.00")
      end

      expect(page).not_to have_content("pot_3")
      expect(page).not_to have_link("#{item_3.name}", href: item_path(item_3))
    end
  end

  describe 'as an admin' do
    it 'lets me see all items in the system except disabled ones' do
      admin = User.create(username: 'Sarah', street: "5345", city: "San Jose", state: "CA", zip_code: 01000, email: "sarah@54321", password: "password", role: 2, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)


      visit items_path

      expect(page).to have_content("Items Catalog")

      within "#item-#{item_1.id}" do
        expect(page).to have_content("pot_1")
        expect(page).to have_link("#{item_1.name}", href: item_path(item_1))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 30")
        expect(page).to have_content("Price: $2.50")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("pot_2")
        expect(page).to have_link("#{item_2.name}", href: item_path(item_2))
        # expect(page).to have_link("#{item_1.thumbnail}", href: item_path(item_1))
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 20")
        expect(page).to have_content("Price: $3.00")
      end

      expect(page).not_to have_content("pot_3")
      expect(page).not_to have_link("#{item_3.name}", href: item_path(item_3))
    end
  end

  describe 'as visitor' do
    it 'lets me see an area with statistics' do
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

      visit items_path

      within "item-statistics" do
        within ".statistics-column-1" do
          expect(page).to have_content("5 Most Popular Items")
          expect(page).to have_content("#{item_10.name}: #{item_10.total_fulfilled}")
          expect(page).to have_content("#{item_9.name}: #{item_9.total_fulfilled}")
          expect(page).to have_content("#{item_8.name}: #{item_8.total_fulfilled}")
          expect(page).to have_content("#{item_7.name}: #{item_7.total_fulfilled}")
          expect(page).to have_content("#{item_6.name}: #{item_6.total_fulfilled}")
        end
        within ".statistics-column-2" do
          expect(page).to have_content("5 Least Popular Items")
          expect(page).to have_content("#{item_1.name}: #{item_1.total_fulfilled}")
          expect(page).to have_content("#{item_2.name}: #{item_2.total_fulfilled}")
          expect(page).to have_content("#{item_3.name}: #{item_3.total_fulfilled}")
          expect(page).to have_content("#{item_4.name}: #{item_4.total_fulfilled}")
          expect(page).to have_content("#{item_5.name}: #{item_5.total_fulfilled}")
        end
      end
    end
  end
end
