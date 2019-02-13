class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||=Hash.new(0)

    redirect_to items_path
  end

  def show
  end

end
