class Order < ApplicationRecord

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'fufilled', 'cancelled']

  def total_item_quantity
    order_items.sum(:quantity)
  end

  def total_item_price
    order_items.sum(:current_price)
  end
end
