require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do

  describe 'when I visit the merchant index' do
    it 'shows top three merchants that sold the most items by price and qty'

    it 'shows the top three merchants with the fastest fulfillment times'

    it 'shows the bottom three merchants with the slowest fulfillment times'

    it 'shows the top three states with the highest number of orders shipped to'

    it 'shows the top three cities with the highest number of orders shipped to'

    it 'shows the top three largest orders by quantity of items shipped with their qty'
  end
end
