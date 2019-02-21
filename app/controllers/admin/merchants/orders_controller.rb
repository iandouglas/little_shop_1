class Admin::Merchants::OrdersController < ApplicationController

  def show
    merchant = User.find(params[:id])
   @order = Order.find(params[:order_id])
   @items = @order.items_for_merchant(merchant.id)
  end

  def edit
    OrderItem.where(item_id: params[:item]).where(order_id: params[:order_id]).each do |oi|
      oi.fulfilled = 1
      oi.save
    end
    item = Item.find(params[:item])
    item.quantity - params[:orderquan].to_i
    item.save
    plural_item = item.name.pluralize(params[:orderquan].to_i)
    flash[:success] = "You have successfully fulfilled #{plural_item} for this order."
    redirect_to admin_merchant_order_path(params[:id], params[:order_id])
  end
end
