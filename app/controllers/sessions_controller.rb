class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in user
      redirect_to home_path
    else
      flash.now[:alert] = "Invalid email/password!"
      render :new
    end
  end

  def destroy
    log_out
  end
end
