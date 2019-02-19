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
    self.enabled = "disabled"
    self.save
  end

  def self.for_merchant(id)
    where(user_id: id)
    .joins(:order_items)
    .group(:name)
    .sum("order_items.quantity")
  end
end
