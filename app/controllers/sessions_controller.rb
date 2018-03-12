class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash.now[:alert] = "Wrong Email and/or Password!"
      render :new
    end
  end
end
