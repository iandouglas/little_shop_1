require 'rails_helper'

RSpec.describe 'as visitor', type: :feature do
  describe 'as visitor' do
    it 'lets me add an item to my cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      item = Item.create!(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
      visit item_path(item.id)

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
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
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
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to_not have_content("Cart(0)")
      expect(page).to_not have_button('Add to Cart')
    end
  end

  describe 'as registered admin' do
    it 'lets me add an item to my cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 2, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to_not have_content("Cart(0)")
      expect(page).to_not have_button('Add to Cart')
    end
  end

  describe 'as a visitor or registered user' do
    it 'shows me all items in my cart and quanitity, shows total price, and link to clear all my items' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/81%2BG9LfH-uL._SL1500_.jpg', user: user)
      item_2 = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 0.01, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/81%2BG9LfH-uL._SL1500_.jpg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit item_path(item.id)
      click_button 'Add to Cart'
      visit item_path(item_2.id)
      click_button 'Add to Cart'
      click_link 'Cart(2)'

      expect(page).to have_content("#{item.name}")
      expect(page).to have_content("Merchant: #{user.username}")
      expect(page).to have_content("Price: $#{item.price}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Total: $2.49")
      expect(page).to have_content("Cart Total: $2.50")
      expect(page).to have_button("Empty Cart")
    end

    it 'tells me i have no items in my cart if i have not added items to my cart yet' do
      visit items_path
      click_link 'Cart(0)'

      expect(page).to have_content('You Have No Items In Your Cart')
      expect(page).to_not have_button('Empty Cart')
    end

    it 'emptys my cart when i click on Empty Cart' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/81%2BG9LfH-uL._SL1500_.jpg', user: user)
      item_2 = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 0.01, thumbnail: 'https://images-na.ssl-images-amazon.com/images/I/81%2BG9LfH-uL._SL1500_.jpg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit item_path(item.id)
      click_button 'Add to Cart'
      visit item_path(item_2.id)
      click_button 'Add to Cart'
      click_link 'Cart(2)'
      click_button 'Empty Cart'

      expect(page).to have_content('Cart(0)')
      expect(page).to have_content('You Have No Items In Your Cart')
    end
  end

end
