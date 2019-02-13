require 'rails_helper'

RSpec.describe 'as visitor or user', type: :feature do
  describe 'as visitor' do
    it 'lets me add an item to my cart' do
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumnail: 'thumbnail.jpeg')
      visit item_path(item)

      expect(page).to have_content("Cart(0)")

      click_button 'Add to Cart'


      expect(current_path).to eq(items_path)
      expect(page).to have_content("Cart(1)")
      expect(page).to have_content("#{item.name} has been succesfully added to your cart.")
    end
  end

end
