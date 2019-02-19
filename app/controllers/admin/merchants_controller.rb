class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def index
    @merchants = User.where(role: 'merchant')
  end

  def show
    @merchant = User.find(params[:id])
  end
end
