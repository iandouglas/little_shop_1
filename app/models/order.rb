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

  def total_item_quantity_for_merchant(id)
    merchant_items = items.where(user_id: id)
    order_items.where(item_id: merchant_items).sum(:quantity)
  end

  def total_item_price_for_merchant(id)
    merchant_items = items.where(user_id: id)
    order_items.where(item_id: merchant_items).sum { |order| order.current_price * order.quantity }
  end

  def self.for_merchant(id)
    where(status: 0).includes(:items).where(items: {user_id: id})
  end

  def self.top_biggest_orders
    self.joins(:order_items)
    .select("orders.id, sum(order_items.quantity) as item_count")
    .where(status: 1)
    .order("item_count DESC")
    .group(:id)
    .limit(3)
  end
end
