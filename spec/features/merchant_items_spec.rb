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
      expect(page).to have_link('Disable Item')
    end
    within "#item-#{item_2.id}" do
      expect(page).to have_content("Name: pot")
      expect(page).to have_link('Enable Item')
    end
    within "#item-#{item_3.id}" do
      expect(page).to have_content("Name: house")
      expect(page).to have_link('Delete Item')
    end
    expect(page).to_not have_content('plant')
    end
  end
