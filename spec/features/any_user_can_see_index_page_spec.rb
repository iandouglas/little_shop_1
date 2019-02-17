require 'rails_helper'

RSpec.describe 'When I visit the items catalog', type: :feature do
  describe 'as visitor' do
    it 'lets me see all items in the system except disabled ones' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create!(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create!(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create!(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", enabled: 1, user: merchant_2)


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
        expect(page).to have_content("Merchant: Jon")
        expect(page).to have_content("Items in stock: 20")
        expect(page).to have_content("Price: $3.00")
      end
    end
  end

end
