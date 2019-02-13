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
      flash[:error] = "You have already logged in"
      redirect_to root_path
    elsif merchant_user?
      flash[:error] = "You have already logged in"
      redirect_to dashboard_path
    elsif regular_user?
      flash[:error] = "You have already logged in"
      redirect_to profile_path
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
      flash[:error] = "The given credentials were incorrect"
      render :new
    end
  end

  def destroy
    if current_user
      session.clear
      flash[:success] = "You have successfully logged out"
      redirect_to root_path
    else
      render :file => './public/404.html', status: 404
    end
  end
end
