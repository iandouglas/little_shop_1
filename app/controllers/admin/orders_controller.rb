class Admin::OrdersController < ApplicationController
  before_action :require_admin

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    order  = Order.find(params[:id])
    items = OrderItem.where(order_id: params[:id])
    items.each do |item|
      if item.fulfilled?
        restore = Item.find(item.item_id)
        restore[:quantity] += item.quantity
        restore.save
      end
      item.fulfilled = 0
      item.save
    end
    order.status = 2
    order.save
    flash[:success] = "This order has been cancelled"
    redirect_to admin_order_path(order)
  end
end
