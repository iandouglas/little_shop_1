require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of :username}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip_code}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password_digest}
    it {should validate_uniqueness_of :email}
  end

  describe 'relationships' do
    it {should have_many :orders}
    it {should have_many :items}
  end

  describe 'instance methods' do
    describe '.top_items_for_merchant' do
      it 'returns items with the total quantity sold for each item for a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create(username: 'bobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@5421", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'mboo', description: "haha", quantity: 12, price: 2.5, thumbnail: "steve.jpg", user_id: merchant_2.id)
        order_1 = Order.create(user_id: user.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 0, current_price: 2.50, quantity: 3)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 3)

        result = merchant.top_items_for_merchant(3)
        result_2 = merchant_2.top_items_for_merchant(1)

        expect(result.first.name).to eq('meh')
        expect(result.first.total_quan).to eq(2)
        expect(result.length).to eq(1)
        expect(result_2.length).to eq(1)
        expect(result_2.first.name).to eq('mboo')
        expect(result_2.first.total_quan).to eq(3)
      end
    end
    describe '.top_states_for_merchant' do
      it 'returns the states where merchant has sent the most items and the quantity' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        user_tom = User.create(username: 'tom', street: "1234", city: "tom", state: "tommy", zip_code: 12345, email: "tommy", password: "tommy", role: 0, enabled: 0)
        user_don = User.create(username: 'don', street: "1234", city: "don", state: "donmy", zip_code: 12345, email: "donnmmy", password: "tommy", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 40, price: 9.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 15, price: 3.75, thumbnail: "steve.jpg", user_id: merchant.id)
        item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "steve.jpg", user_id: merchant.id)
        item_5 = Item.create!(name: 'house', description: "oreijvioe", quantity: 80, price: 1.99, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        order_3 = Order.create(user_id: user_tom.id)
        order_4 = Order.create(user_id: user_don.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
        OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_4.id, order_id: order_3.id, fulfilled: 1, current_price: 80, quantity: 5)
        OrderItem.create(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 1.99, quantity: 6)

        result = merchant.top_states_for_merchant(3)

        expect(result.length).to eq(3)
        expect(result.first.state).to eq('bobby')
        expect(result.first.quantity).to eq(9)
        expect(result[1].state).to eq('donmy')
        expect(result[1].quantity).to eq(6)
      end
    end
    describe '.top_cities_for_merchant' do
      it 'returns the cities where merchant has sent the most items and the quantity' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        user_tom = User.create(username: 'tom', street: "1234", city: "tom", state: "tommy", zip_code: 12345, email: "tommy", password: "tommy", role: 0, enabled: 0)
        user_don = User.create(username: 'don', street: "1234", city: "don", state: "donmy", zip_code: 12345, email: "donnmmy", password: "tommy", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 40, price: 9.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 15, price: 3.75, thumbnail: "steve.jpg", user_id: merchant.id)
        item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "steve.jpg", user_id: merchant.id)
        item_5 = Item.create!(name: 'house', description: "oreijvioe", quantity: 80, price: 1.99, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        order_3 = Order.create(user_id: user_tom.id)
        order_4 = Order.create(user_id: user_don.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
        OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_4.id, order_id: order_3.id, fulfilled: 1, current_price: 80, quantity: 5)
        OrderItem.create(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 1.99, quantity: 6)

        result = merchant.top_cities_for_merchant(3)

        expect(result.length).to eq(3)
        expect(result.first.city).to eq('bob')
        expect(result.first.state).to eq('bobby')
        expect(result.first.quantity).to eq(9)
        expect(result[1].city).to eq('don')
        expect(result[1].state).to eq('donmy')
        expect(result[1].quantity).to eq(6)
      end
    end

    describe '.top_user_by_orders' do
      it 'returns the user whos made the most orders by a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        user_tom = User.create(username: 'tom', street: "1234", city: "tom", state: "tommy", zip_code: 12345, email: "tommy", password: "tommy", role: 0, enabled: 0)
        user_don = User.create(username: 'don', street: "1234", city: "don", state: "donmy", zip_code: 12345, email: "donnmmy", password: "tommy", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 40, price: 9.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 15, price: 3.75, thumbnail: "steve.jpg", user_id: merchant.id)
        item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "steve.jpg", user_id: merchant.id)
        item_5 = Item.create!(name: 'house', description: "oreijvioe", quantity: 80, price: 1.99, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        order_5 = Order.create(user_id: user.id)
        order_3 = Order.create(user_id: user_tom.id)
        order_4 = Order.create(user_id: user_don.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
        OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_3.id, order_id: order_5.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_4.id, order_id: order_3.id, fulfilled: 1, current_price: 80, quantity: 5)
        OrderItem.create(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 1.99, quantity: 6)

        result = merchant.top_user_by_orders(1)

        expect(result.length).to eq(1)
        expect(result.first.username).to eq('bob')
        expect(result.first.quantity).to eq(3)
      end
    end

    describe '.top_user_by_items' do
      it 'returns the user whos purchased the most quantity from a merchant' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        user_tom = User.create(username: 'tom', street: "1234", city: "tom", state: "tommy", zip_code: 12345, email: "tommy", password: "tommy", role: 0, enabled: 0)
        user_don = User.create(username: 'don', street: "1234", city: "don", state: "donmy", zip_code: 12345, email: "donnmmy", password: "tommy", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 40, price: 9.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 15, price: 3.75, thumbnail: "steve.jpg", user_id: merchant.id)
        item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "steve.jpg", user_id: merchant.id)
        item_5 = Item.create!(name: 'house', description: "oreijvioe", quantity: 80, price: 1.99, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        order_5 = Order.create(user_id: user.id)
        order_3 = Order.create(user_id: user_tom.id)
        order_4 = Order.create(user_id: user_don.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
        OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_3.id, order_id: order_5.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_4.id, order_id: order_3.id, fulfilled: 1, current_price: 80, quantity: 5)
        OrderItem.create(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 1.99, quantity: 6)

        result = merchant.top_user_by_items(1)

        expect(result.length).to eq(1)
        expect(result.first.username).to eq('bob')
        expect(result.first.quantity).to eq(13)
      end
    end

    describe '.top_user_by_price' do
      it 'returns the 3 user whos spent the most money for a merchants items' do
        user = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        user_tom = User.create(username: 'tom', street: "1234", city: "tom", state: "tommy", zip_code: 12345, email: "tommy", password: "tommy", role: 0, enabled: 0)
        user_don = User.create(username: 'don', street: "1234", city: "don", state: "donmy", zip_code: 12345, email: "donnmmy", password: "tommy", role: 0, enabled: 0)
        merchant = User.create(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        item_1 = Item.create(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_2 = Item.create(name: 'pot', description: "fjndkjknk", quantity: 40, price: 9.50, thumbnail: "steve.jpg", user_id: merchant.id)
        item_3 = Item.create(name: 'crayon', description: "oreijvioe", quantity: 15, price: 3.75, thumbnail: "steve.jpg", user_id: merchant.id)
        item_4 = Item.create(name: 'marker', description: "oreijvioe", quantity: 50, price: 80, thumbnail: "steve.jpg", user_id: merchant.id)
        item_5 = Item.create!(name: 'house', description: "oreijvioe", quantity: 80, price: 1.99, thumbnail: "steve.jpg", user_id: merchant.id)
        order_1 = Order.create(user_id: user.id)
        order_2 = Order.create(user_id: user.id)
        order_3 = Order.create(user_id: user_tom.id)
        order_4 = Order.create(user_id: user_don.id)
        OrderItem.create(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 2)
        OrderItem.create(item_id: item_2.id, order_id: order_1.id, fulfilled: 1, current_price: 9.50, quantity: 3)
        OrderItem.create(item_id: item_3.id, order_id: order_2.id, fulfilled: 1, current_price: 3.75, quantity: 4)
        OrderItem.create(item_id: item_4.id, order_id: order_3.id, fulfilled: 1, current_price: 80, quantity: 5)
        OrderItem.create(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 1.99, quantity: 6)

        result = merchant.top_users_by_price(3)

        expect(result.length).to eq(3)
        expect(result.first.username).to eq('tom')
        expect(result.first.money_spent).to eq(400)
        expect(result.last.username).to eq('don')
        expect(result.last.money_spent).to eq(11.94)
      end
    end
  end

  describe 'class methods' do
    describe 'self.top_merchants_by_price_and_qty' do
      it 'shows the top three merchants who have sold the most by price and quantity' do
        user = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
        merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
        order_1 = Order.create!(user_id: user.id)
        order_2 = Order.create!(user_id: user.id)
        order_3 = Order.create!(user_id: user.id)
        order_4 = Order.create!(user_id: user.id)
        item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
        item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
        item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
        item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
        OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 5)
        OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5)
        OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5)
        OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 50.00, quantity: 5)

        result = User.top_merchants_by_price_and_qty

        expect(result[0].username).to eq("steve")
        expect(result[0].revenue).to eq(1000.0)
        expect(result[1].username).to eq("cappy")
        expect(result[1].revenue).to eq(500.00)
        expect(result[2].username).to eq("jobby")
        expect(result[2].revenue).to eq(250.00)
      end
    end

    describe 'self.fullfillment_time(asc/desc)' do
      it 'returns the top or bottom three merchants by their avg fulfillment time' do
        user = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12345@54321", password: "password", role: 0, enabled: 0)
        merchant_1 = User.create!(username: 'bob', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1@54321", password: "password", role: 1, enabled: 0)
        merchant_2 = User.create!(username: 'steve', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12@54321", password: "password", role: 1, enabled: 0)
        merchant_4 = User.create!(username: 'jobby', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "1234@54321", password: "password", role: 1, enabled: 0)
        merchant_3 = User.create!(username: 'cappy', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "123@54321", password: "password", role: 1, enabled: 0)
        merchant_5 = User.create!(username: 'andre', street: "1234", city: "bob", state: "bobby", zip_code: 12345, email: "12312@54321", password: "password", role: 1, enabled: 0)
        order_1 = Order.create!(user_id: user.id)
        order_2 = Order.create!(user_id: user.id)
        order_3 = Order.create!(user_id: user.id)
        order_4 = Order.create!(user_id: user.id)
        order_4 = Order.create!(user_id: user.id)
        item_1 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 2.50, thumbnail: "steve.jpg", user_id: merchant_1.id)
        item_2 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 200.00, thumbnail: "steve.jpg", user_id: merchant_2.id)
        item_3 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 100.00, thumbnail: "steve.jpg", user_id: merchant_3.id)
        item_4 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_4.id)
        item_5 = Item.create!(name: 'meh', description: "haha", quantity: 12, price: 50.00, thumbnail: "steve.jpg", user_id: merchant_5.id)
        OrderItem.create!(item_id: item_1.id, order_id: order_1.id, fulfilled: 1, current_price: 2.50, quantity: 5, created_at: 1.days.ago)
        OrderItem.create!(item_id: item_2.id, order_id: order_2.id, fulfilled: 1, current_price: 200.00, quantity: 5, created_at: 2.days.ago)
        OrderItem.create!(item_id: item_3.id, order_id: order_3.id, fulfilled: 1, current_price: 100.00, quantity: 5, created_at: 3.days.ago)
        OrderItem.create!(item_id: item_4.id, order_id: order_4.id, fulfilled: 1, current_price: 100.00, quantity: 5, created_at: 4.days.ago)
        OrderItem.create!(item_id: item_5.id, order_id: order_4.id, fulfilled: 1, current_price: 50.00, quantity: 5, created_at: 5.days.ago)

        result_asc = User.top_merchants_by_price_and_qty(asc)
        result_desc = User.top_merchants_by_price_and_qty(desc)

        expect(result_asc.first.username).to eq("bob")
        expect(result_asc.second.username).to eq("steve")
        expect(result_asc.third.username).to eq("jobby")
        
        expect(result_desc.first.username).to eq("andre")
        expect(result_desc.second.username).to eq("cappy")
        expect(result_desc.third.username).to eq("jobby")
      end
    end

    describe 'self.top_shipped_states' do
      it 'shows the top three states by number of shipped items'
    end

    describe 'self.top_shipped_cities' do
      it 'shows the top three cities by number of shipped items'
    end

    describe 'self.top_biggest_orders' do
      it 'shows the top three orders by qty of items shipped'
    end
  end
end
