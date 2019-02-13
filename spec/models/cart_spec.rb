require 'rails_helper'

RSpec.describe Cart do
  describe 'class_methods' do

  end

  describe 'instance_methods' do
    describe '.total' do
      it 'should return the total ammount of items in its contents' do
        cart = Cart.new({
          '1'=>'6',
          '2'=>'2'
          })
          expect(cart.total).to eq(8)
      end
    end
  end
end
