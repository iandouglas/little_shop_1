require 'rails_helper'

RSpec.describe 'as visitor', type: :feature do

  it 'sees a link to the welcome/home page' do

    visit items_path

    click_link "Home"

    expect(current_path).to eq(root_path)
  end


end
