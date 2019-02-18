class ItemsController < ApplicationController

  def index
    @items = Item.where(enabled: "enabled")
  end

  def show
    @item = Item.find(params[:id])
  end
end
