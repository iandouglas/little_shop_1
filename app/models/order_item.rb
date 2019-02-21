class OrderItem < ApplicationRecord
  after_save :update_order
  belongs_to :order
  belongs_to :item

  validates_presence_of :item_id
  validates_presence_of :order_id
  validates_presence_of :fulfilled
  validates_presence_of :current_price
  validates_presence_of :quantity

  enum fulfilled: ['unfulfilled', 'fulfilled']

  def update_order
    any_unfulfilled = OrderItem.where(order_id: order_id).pluck(:fulfilled).include?("unfulfilled")
    if any_unfulfilled
      Order.find(order_id).update(status: 0)
    else
      Order.find(order_id).update(status: 1)
    end
  end
end
