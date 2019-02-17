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
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user: user)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        expect(cart.all_items).to eq({item => 6, item_2 => 2})
      end
    end

    describe '.subtotal' do
      it 'should return me all items in the cart' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user: user)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        expect(cart.subtotal(item_2)).to eq(27.0)
      end
    end

    describe '.items_subtotal' do
      it 'should return me all items in the cart' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user: user)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        expect(cart.grand_total).to eq(41.94)
      end
    end

    describe '.update_items_quantity' do
      it 'should change the quantity of one item by one more or one less' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 30, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
        item_2 = Item.create(name: 'crayon', description:'small crayon for plants', quantity: 40, price: 13.5, thumbnail: 'thumbnail.jpeg', user: user)
        cart = Cart.new({
          "#{item.id}" => 6,
          "#{item_2.id}" => 2
          })

        cart.update_items_quantity('add', item.id.to_s)
        expected = {
          "#{item.id}" => 7,
          "#{item_2.id}" => 2
          }

        expect(cart.contents).to eq(expected)

        cart.update_items_quantity('remove', item_2.id.to_s)
        expected_2 = {
          "#{item.id}" => 7,
          "#{item_2.id}" => 1
          }

        expect(cart.contents).to eq(expected_2)
      end
    end

    describe '.update_items_quantity' do
      it 'should not let users add more items than are in stock' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        item = Item.create(name: 'pot', description:'small pot for plants', quantity: 5, price: 2.49, thumbnail: 'thumbnail.jpeg', user: user)
        cart = Cart.new({
          "#{item.id}" => 5,
          })

        cart.update_items_quantity('add', item.id.to_s)
        expected = {
          "#{item.id}" => 5,
          }

        expect(cart.contents).to eq(expected)
      end
    end
  end
end
