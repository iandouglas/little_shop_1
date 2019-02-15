class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully registered your account and logged in"
      redirect_to profile_path
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
    @user = current_user
    if profile_params[:password] == ""
      new_params = profile_params.except(:password)
      @user.update(new_params)
    elsif profile_params[:password]
      @user.update(profile_params)
    end
    if @user.save
      redirect_to profile_path
    else
      flash[:error] = "This should be error block messages"
      render :edit
    end
  end

  def profile
      render :file => './public/404.html', status: 404 unless regular_user?
  end

  def dashboard
      render :file => './public/404.html', status: 404 unless merchant_user?
  end
  private
  def user_params
    params.require(:user).permit(:username, :street, :city, :state, :zip_code, :email, :password)
  end

  def profile_params
  params.require(:profile).permit(:username, :street, :city, :state, :zip_code, :email, :password, :confirm_password)
  end

end
