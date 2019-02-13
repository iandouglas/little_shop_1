class SessionsController < ApplicationController

  def new
    if admin_user?
      flash[:error] = "You have already logged in"
      redirect_to root_path
    elsif merchant_user?
      flash[:error] = "You have already logged in"
      redirect_to dashboard_path
    elsif regular_user?
      flash[:error] = "You have already logged in"
      redirect_to profile_path
    end
  end

  def create
    if admin_user?
      redirect_to root_path
      flash[:error] = "You have already logged in"
    elsif merchant_user?
      redirect_to dashboard_path
      flash[:error] = "You have already logged in"
    elsif regular_user?
      redirect_to profile_path
      flash[:error] = "You have already logged in"
    end
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if admin_user?
        flash[:success] = "You are now logged in"
        redirect_to root_path
      elsif merchant_user?
        flash[:success] = "You are now logged in"
        redirect_to dashboard_path
      elsif regular_user?
        flash[:success] = "You are now logged in"
        redirect_to profile_path
      end
    else
      render :new
      flash[:error] = "The given credentials were incorrect"
    end
  end

  def destroy
    unless regular_user?
      render :file => './public/404.html', status: 404
    end
  end
end
