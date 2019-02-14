class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully registered your account"
      redirect_to profile_path(@user)
    else
      if User.find_by(email: @user.email)
        flash[:error] = "This E-mail is already registered"
        render :new
      else
        flash[:error] = "You are missing information"
        render :new
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if profile_params[:password] && profile_params[:confirm_password] == ""
      new_params = profile_params.except(:password, :confirm_password)
      @user.update(new_params)
    elsif profile_params[:password] == profile_params[:confirm_password]
      @user.update(profile_params.except(:confirm_password))
      @user.save
    end

    @user.save
    redirect_to profile_path
  end

  def profile
    unless regular_user?
      render :file => './public/404.html', status: 404
    end
  end

  def dashboard
    unless merchant_user?
      render :file => './public/404.html', status: 404
    end
  end
  private
  def user_params
    params.require(:user).permit(:username, :street, :city, :state, :zip_code, :email, :password)
  end

  def profile_params
  params.require(:profile).permit(:username, :street, :city, :state, :zip_code, :email, :password, :confirm_password)
  end

end
