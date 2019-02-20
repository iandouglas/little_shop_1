class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def show
    @merchant = User.find(params[:id])
  end
end
