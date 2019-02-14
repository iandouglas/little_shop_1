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
      it 'should add items to the cart' do
        cart = Cart.new({
          '1'=> 6,
          '2'=> 2
          })
        cart.add_item('1')
        expect(cart.contents).to eq({'1'=>7, '2'=>2})
      end
    end

    describe '.all_items' do
      it 'should return me all items in the cart' do
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        expect(cart.all_items).to eq({item: 6, item_2: 2})
      end
    end

    describe '.items_subtotal' do
      it 'should return me all items in the cart' do
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user_id: merchant.id)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        expect(cart.all_items).to eq(41.94)
      end
    end
  end
end
