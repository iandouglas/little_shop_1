equire 'rails_helper'

RSpec.describe "When I visit an item's show page from the items catalog", type: :feature do
  describe 'as visitor' do
    it 'lets me see all information for this item' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)

      item_1 = Item.create(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)

      visit item_path(item_1)

      expect(page).to have_content( "#{item_1.name}" )
      expect(page).to have_content( "#{item_1.description}" )
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(item_1.thumbnail)}')]")
      expect(page).to have_content( "#{user.username}" )
      expect(page).to have_content( "#{item_1.quantity}" )
      expect(page).to have_content( "#{item_1.price}" )
      expect(page).to have_content( "#{item_1.average_fulfilled_time}" )

      expect(page).to_not have_content( "#{item_2.name}" )
      expect(page).to_not have_content( "#{item_2.description}" )
      expect(page).to_not have_xpath("//img[contains(@src,'#{File.basename(item_2.thumbnail)}')]")
      expect(page).to_not have_content( "#{user.username}" )
      expect(page).to_not have_content( "#{item_2.quantity}" )
      expect(page).to_not have_content( "#{item_2.price}" )
      expect(page).to_not have_content( "#{item_2.average_fulfilled_time}" )
    end
  end
end
