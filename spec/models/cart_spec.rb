require 'rails_helper'

RSpec.describe Cart do
  describe 'class_methods' do

  end

  describe 'instance_methods' do
    describe '.total' do
      it 'should return the total ammount of items in its contents' do
        cart = Cart.new({
          '1'=> 6,
          '2'=> 2
          })
          expect(cart.total).to eq(8)
      end
    end

    describe '.add_items' do
      it 'should add items to the cart'
        cart = Cart.new({
          '1'=> 6,
          '2'=> 2
          })
        cart.add_item('1')
        expect(cart.contents).to eq({'1'=>7, '2'=>2})
      end
    end
  end
end
