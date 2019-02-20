require 'rails_helper'

RSpec.describe 'as merchant', type: :feature do

  it 'shows me all my items and only my items' do
    user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
    merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
    merchant_2 = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
    item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
    item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id, enabled: 1)
    item_3 = Item.create(name: 'house', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
    item_4 = Item.create(name: 'plant', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant_2.id)
    order_1 = Order.create(user_id: user.id)
    OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit dashboard_items_path

    expect(page).to have_link('Add New Item')
    within "#item-#{item_1.id}" do
      expect(page).to have_content("Name: meh")
      expect(page).to have_content("ID: #{item_1.id}")
      expect(page).to have_xpath("//img[@src='https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png']")
      expect(page).to have_content("Price: #{item_1.price}")
      expect(page).to have_content("Current Inventory: #{item_1.quantity}")
      expect(page).to have_link("Edit Item")
      expect(page).to have_button('Disable Item')
    end
    within "#item-#{item_2.id}" do
      expect(page).to have_content("Name: pot")
      expect(page).to have_button('Enable Item')
    end
    within "#item-#{item_3.id}" do
      expect(page).to have_content("Name: house")
      expect(page).to have_link('Delete Item')
    end
    expect(page).to_not have_content('plant')
    end

    it "allows me to add a new item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id, enabled: 1)
      item_3 = Item.create(name: 'house', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      click_link 'Add New Item'

      expect(current_path).to eq(dashboard_new_item_path)

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Thumbnail', with: 'https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(dashboard_items_path)

      expect(page).to have_content("You have succesfully added Juice to your Items.")
      expect(page).to have_content("Price: 3.49")
    end

    it "allows me to edit an item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      within "#item-#{item_1.id}" do
        click_link 'Edit Item'
      end
      expect(current_path).to eq(dashboard_edit_item_path(item_1))

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Thumbnail', with: 'https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(dashboard_items_path)

      expect(page).to have_content("You have succesfully updated Juice in your Items.")
      expect(page).to have_content("Price: 3.49")
    end

    it "adds default image" do
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      visit dashboard_items_path
      click_link 'Add New Item'

      expect(current_path).to eq(dashboard_new_item_path)

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(dashboard_items_path)

      expect(page).to have_content("You have succesfully added Juice to your Items.")
      expect(page).to have_xpath("//img[@src='https://res.cloudinary.com/teepublic/image/private/s--NfYU3VuJ--/t_Preview/b_rgb:ffffff,c_limit,f_jpg,h_630,q_90,w_630/v1484987720/production/designs/1129239_1.jpg']")
    end

    it "does not let users create items missing required fields" do
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      visit dashboard_items_path
      click_link 'Add New Item'

      fill_in 'Price', with: '0'
      fill_in 'Quantity', with: '0'
      click_button 'Save Item'

      expect(current_path).to eq(dashboard_new_item_path)

      expect(page).to have_content("Price must be greater than 0")
      expect(page).to have_content("Quantity must be greater than 0")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    it "does not let users edit items missing required fields" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      within "#item-#{item_1.id}" do
        click_link 'Edit Item'
      end
      expect(current_path).to eq(dashboard_edit_item_path(item_1))
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      fill_in 'Price', with: '0'
      fill_in 'Quantity', with: '0'
      click_button 'Save Item'

      expect(current_path).to eq(dashboard_edit_item_path(item_1))

      expect(page).to have_content("Price must be greater than 0")
      expect(page).to have_content("Quantity must be greater than 0")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    it "allows me to delete an item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      within "#item-#{item_1.id}" do
        click_link 'Delete Item'
      end

      expect(page).to_not have_content('meh')
    end
  end
