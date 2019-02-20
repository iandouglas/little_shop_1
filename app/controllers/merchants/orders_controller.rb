class Merchants::OrdersController <  ApplicationController

  def show
     merchant = User.find(current_user.id)
    @order = Order.find(params[:id])
    @items = @order.items_for_merchant(merchant.id)
  end

  def edit
    OrderItem.where(item_id: params[:item]).where(order_id: params[:id]).each do |oi|
      oi.fulfilled = 1
      oi.save
    end
    item = Item.find(params[:item])
    item.quantity - params[:orderquan].to_i
    item.save
    plural_item = item.name.pluralize(params[:orderquan].to_i)
    flash[:success] = "You have successfully fulfilled #{plural_item} for this order."
    redirect_to dashboard_orders_path(params[:id])
  end

  def disable
    item = Item.find(params[:id])
    if item.enabled?
      item.enabled = 'disabled'
      item.save
    end
    flash[:success] = "#{item.name} is now available for sale"
    redirect_to dashboard_items_path
  end

  def enable
    item = Item.find(params[:id])
    if item.disabled?
      item.enabled = 'enabled'
      item.save
    end
    flash[:error] = "#{item.name} is no longer for sale"
    redirect_to dashboard_items_path
  end
end
