require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe 'validations' do
    it {should validate_presence_of :item_id}
    it {should validate_presence_of :order_id}
    it {should validate_presence_of :fulfilled}
    it {should validate_presence_of :current_price}
    it {should validate_presence_of :quantity}
  end

  describe 'realationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end
end
