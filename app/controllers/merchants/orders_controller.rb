class Merchants::OrdersController <  ApplicationController

  def show
     merchant = User.find(current_user.id)
    @order = Order.find(params[:id])
    @items = @order.items_for_merchant(merchant.id)
  end

  def edit
    OrderItem.fulfill_item(:id, params[:item])
    Item.change_quantity(params[:orderquan])
    redirect_to dashboard_orders_path(params[:id])
  end
end
