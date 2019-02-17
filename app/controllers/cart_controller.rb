class CartController < ApplicationController

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
    binding.pry
    @items = @cart.all_items
  end

  def destroy
    session[:cart].clear
    redirect_to cart_index_path
  end

  def delete_item
    session[:cart].delete(params[:id])
    redirect_to cart_index_path
  end

  def add_item
    @cart.update_items_quantity('add', params[:id])
    session[:cart] = @cart.contents
    redirect_to cart_index_path
  end

end
