require 'rails_helper'

RSpec.describe 'as user', type: :feature do
  before(:each) do
    merchant = User.create!(username: 'test', street: '123 main st', city: 'denver', state: 'CO', zip_code: 80216, email: 'test@bob.net', password: 'password', role: 1)
    @item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
    @item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
    visit item_path(@item)
    click_button 'Add to Cart'
    visit item_path(@item)
    click_button 'Add to Cart'
    visit item_path(@item_2)
    click_button 'Add to Cart'
  end
  after(:each) do

  end

  it 'should show me all items in my cart' do
    visit carts_path

    within "#item-#{@item.id}" do
      expect(page).to have_content("#{@item.name}")
      expect(page).to have_content("#{@item.thumbnail}")
      expect(page).to have_content("#{@item.user_id.username}")
      expect(page).to have_content("#{@item.price}")
      expect(page).to have_content(2)
      expect(page).to have_content(4.98)
    end

    within "#item-#{@item_2.id}" do
      expect(page).to have_content("#{@item.name}")
      expect(page).to have_content("#{@item.thumbnail}")
      expect(page).to have_content("#{@item.user_id.username}")
      expect(page).to have_content("#{@item.price}")
      expect(page).to have_content(1)
      expect(page).to have_content(13.5)
    end

    expect(page).to have_content(18.48)
  end
end
