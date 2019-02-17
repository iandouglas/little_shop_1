require 'rails_helper'

RSpec.describe 'When I visit the items catalog', type: :feature do
  describe 'as visitor' do
    it 'lets me see all items in the system except disabled ones' do
      merchant_1 = User.create(username: 'Jon', street: "1234", city: "Dallas", state: "TX", zip_code: 12345, email: "merchant1@54321", password: "password", role: 1, enabled: 0)
      merchant_2 = User.create(username: 'Bob', street: "4321", city: "Denver", state: "CO", zip_code: 80000, email: "merchant2@54321", password: "passwords", role: 1, enabled: 0)

      item_1 = Item.create!(name: 'pot_1', description:'a small pot for plants', quantity: 30, price: 2.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_2 = Item.create!(name: 'pot_2', description:'another small pot for plants', quantity: 20, price: 3.00, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_1)
      item_3 = Item.create!(name: 'pot_3', description:'this is also a small pot for plants', quantity: 10, price: 4.50, thumbnail: "https://i.etsystatic.com/13875023/r/il/0db0e5/1570825768/il_570xN.1570825768_anvx.jpg", user: merchant_2)


      visit items_path

      within "#item-#{book_1.id}" do
        expect(page).to have_content("Book 1 Title")
        expect(page).to have_link("#{book_1.title}", href: book_path(book_1))
        expect(page).to have_content("Average Rating: 2.5")
        expect(page).to have_content("Total Reviews: 2")
        expect(page).to have_content("Length: 111")
        expect(page).to have_content("Year: 1111")
        expect(page).to have_content("Author(s):\nJane Doe")
        expect(page).to have_link("Jane Doe", href: author_path(author_2))
        expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")
      end
    end
  end

  describe 'as registered user' do
    it 'lets me see all items in the system except disabled ones' do
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
    it 'lets me see all items in the system except disabled ones' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to_not have_content("Cart(0)")
      expect(page).to_not have_button('Add to Cart')
    end
  end

  describe 'as registered admin' do
    it 'lets me see all items in the system except disabled ones' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 2, enabled: 0)
      item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to_not have_content("Cart(0)")
      expect(page).to_not have_button('Add to Cart')
    end
  end
end
