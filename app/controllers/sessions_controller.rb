class SessionsController < ApplicationController

  def new

  end

  def destroy
    unless regular_user?
      render :file => './public/404.html', status: 404
    end
  end
end
