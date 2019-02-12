class Users::OrdersController < ApplicationController
  def index
    unless regular_user
      render :file => './public/404.html', status: 404 
    end
  end
end
