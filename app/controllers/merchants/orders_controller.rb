class Merchants::OrdersController <  ApplicationController

  def show
     merchant = User.find(current_user.id)
    @order = Order.find(params[:id])
    @items = @order.items_for_merchant(merchant.id)
  end
end
