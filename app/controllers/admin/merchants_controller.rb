class Admin::MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant')
  end

  def show
    @merchant = User.find(params[:id])
  end
end
