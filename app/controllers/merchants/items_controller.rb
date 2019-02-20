class Merchants::ItemsController < ApplicationController

  def index
    @items = Item.where(user_id: current_user.id)
    @unsold_items = Item.unsold_items(@items)
  end
end
