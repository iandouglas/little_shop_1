require 'rails_helper'

RSpec.describe 'as visitor', type: :feature do

  it 'sees a link to the welcome/home page' do

    visit items_path

    click_link "Home"

    expect(current_path).to eq(root_path)
  end

  it 'should have link to items directory' do

    visit new_user_path

    click_link "Items"

    expect(current_path).to eq(items_path)
  end

  it 'should have link to all merchants' do

    visit new_user_path

    click_link "Merchants"

    expect(current_path).to eq(merchants_path)
  end

  it 'should have link to cart' do

    visit new_user_path

    click_link "Cart"

    expect(current_path).to eq(cart_path)
  end


end
