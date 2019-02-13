class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= @cart.contents

    redirect_to items_path
  end

  def show
  end

end
