class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :description, :quantity, :price, :thumbnail, :enabled, :user_id
  enum enabled: ['enabled', 'disabled']

  def order_quantity(order_id)
    OrderItem.find_by(order_id: order_id).quantity
  end

  def quantity_price(order_id)
    OrderItem.find_by(order_id: order_id).current_price
  end

  def disable_item
    self.enabled = "disabled" # shouldn't this be self.enabled = 1 ?
    self.save
  end

  def self.five_most_popular
    Item.joins(:orders)
    .select("items.*, sum(order_items.quantity) as total_fulfilled")
    .where(order_items: {fulfilled: 'fulfilled'}, items: {enabled: 'enabled'})
    .group(:id)
    .order("total_fulfilled desc")
    .limit(5)
  end

  def self.five_least_popular
    Item.joins(:orders)
    .select("items.*, sum(order_items.quantity) as total_fulfilled")
    .where(order_items: {fulfilled: 'fulfilled'}, items: {enabled: 'enabled'})
    .group(:id)
    .order("total_fulfilled asc")
    .limit(5)
  end

  def average_fulfilled_time
    
  end
end
