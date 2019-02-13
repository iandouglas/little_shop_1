require 'rails_helper'

RSpec.describe 'as visitor', type: :feature do
  describe 'as visitor' do
    it 'lets me add an item to my cart' do
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg')
      visit item_path(item)

      expect(page).to have_content("Cart(0)")

      click_button 'Add to Cart'


      expect(current_path).to eq(items_path)
      expect(page).to have_content("Cart(1)")
      expect(page).to have_content("#{item.name} has been succesfully added to your cart.")
    end
  end

  describe 'as registered user' do
    it 'lets me add an item to my cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)


      expect(page).to have_content("Cart(0)")

      click_button 'Add to Cart'


      expect(current_path).to eq(items_path)
      expect(page).to have_content("Cart(1)")
      expect(page).to have_content("#{item.name} has been succesfully added to your cart.")
    end
  end

  describe 'as registered merchant' do
    it 'lets me add an item to my cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to not_have_content("Cart(0)")
      expect(page).to not_have_button('Add to Cart')
    end
  end

  describe 'as registered admin' do
    it 'lets me add an item to my cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 2, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to not_have_content("Cart(0)")
      expect(page).to not_have_button('Add to Cart')
    end
  end

end
