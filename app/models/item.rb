class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def order_quantity(order_id)
    OrderItem.find_by(order_id: order_id).quantity
  end
end
