class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    @cart.add_item(item_id_str)
    session[:cart] = @cart.contents
    quantity = session[:cart][item_id_str]
    flash[:success] = "#{item.name} has been succesfully added to your cart."
    redirect_to items_path
  end

  def index
    @items = @cart.all_items
  end

end
