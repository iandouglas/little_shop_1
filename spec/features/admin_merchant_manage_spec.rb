require 'rails_helper'

RSpec.describe 'as admin', type: :feature do

    it "allows me to add a new item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      click_link 'Add New Item'

      expect(current_path).to eq(admin_merchant_new_item_path(merchant))

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Thumbnail', with: 'https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(admin_merchant_items_path(merchant))

      expect(page).to have_content("You have succesfully added Juice to your Items.")
      expect(page).to have_content("Price: 3.49")
    end

    it "allows me to edit an item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      within "#item-#{item_1.id}" do
        click_link 'Edit Item'
      end
      expect(current_path).to eq(admin_merchant_edit_item_path(merchant, item_1))

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Thumbnail', with: 'https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(admin_merchant_items_path(merchant))

      expect(page).to have_content("You have succesfully updated Juice in your Items.")
      expect(page).to have_content("Price: 3.49")
    end

    it "adds default image" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id, enabled: 1)
      item_3 = Item.create(name: 'house', description: "oreijvioe", quantity: 12, price: 2.50, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      click_link 'Add New Item'

      expect(current_path).to eq(admin_merchant_new_item_path(merchant))

      fill_in 'Name', with: 'Juice'
      fill_in 'Description', with: 'orangeeeee'
      fill_in 'Price', with: '3.49'
      fill_in 'Quantity', with: '21'
      click_button 'Save Item'

      expect(current_path).to eq(admin_merchant_items_path(merchant))

      expect(page).to have_content("You have succesfully added Juice to your Items.")
      expect(page).to have_xpath("//img[@src='https://res.cloudinary.com/teepublic/image/private/s--NfYU3VuJ--/t_Preview/b_rgb:ffffff,c_limit,f_jpg,h_630,q_90,w_630/v1484987720/production/designs/1129239_1.jpg']")
    end

    it "does not let admin create items missing required fields" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      order_1 = Order.create(user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      click_link 'Add New Item'

      expect(current_path).to eq(admin_merchant_new_item_path(merchant))

      fill_in 'Price', with: '0'
      fill_in 'Quantity', with: '0'
      click_button 'Save Item'

      expect(current_path).to eq(admin_merchant_new_item_path(merchant))

      expect(page).to have_content("Price must be greater than 0")
      expect(page).to have_content("Quantity must be greater than 0")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    it "does not let admin edit items missing required fields" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      within "#item-#{item_1.id}" do
        click_link 'Edit Item'
      end

      expect(current_path).to eq(admin_merchant_edit_item_path(merchant, item_1))

      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      fill_in 'Price', with: '0'
      fill_in 'Quantity', with: '0'
      click_button 'Save Item'

      # expect(current_path).to eq(admin_merchant_new_item_path(merchant, item_1))

      expect(page).to have_content("Price must be greater than 0")
      expect(page).to have_content("Quantity must be greater than 0")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    it "allows me to delete an item" do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      within "#item-#{item_1.id}" do
        click_button 'Delete Item'
      end

      expect(current_path).to eq(admin_merchant_items_path(merchant))

      expect(page).to have_content('You have succesfully deleted meh from your items.')
      expect(page).to_not have_content('haha')
      expect(page).to_not have_content('12')
      expect(page).to_not have_content('$2.50')
    end

    it 'can disable item' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      expect(item_1.enabled?).to be true

      within "#item-#{item_1.id}" do
        click_button "Disable Item"
      end

      expect(Item.find(item_1.id).disabled?).to be true
      expect(current_path).to eq(admin_merchant_items_path(merchant))
      expect(page).to have_content("#{item_1.name} is now available for sale")
    end

    it 'can enable item' do
      user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123321", password: "password", role: 0, enabled: 0)
      merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 1, enabled: 0)
      admin = User.create!(username: 'happy', street: '432 main st', city: 'steve', state: 'CO', zip_code: 80126, email: 'te@bob.net', password: 'password', role: 2)
      item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "https://66.media.tumblr.com/60aeee62dc1aee0c3c0fbad1702eb860/tumblr_inline_pfp352ORsk1r4hkfd_250.png", user_id: merchant.id, enabled: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      expect(item_1.disabled?).to be true

      within "#item-#{item_1.id}" do
        click_button "Enable Item"
      end

      expect(Item.find(item_1.id).enabled?).to be true
      expect(current_path).to eq(admin_merchant_items_path(merchant))
      expect(page).to have_content("#{item_1.name} is no longer for sale")
    end
  end
