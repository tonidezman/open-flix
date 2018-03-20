class ResetPasswordsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    user = User.find_by(email: email)
    if user
      new_token = ResetPassword.generate_token(user.email)
      reset_url = edit_reset_password_url(new_token, email: user.email)
      UserMailer.reset_password_instruction(user.email, reset_url).deliver_later

      flash[:notice] = "Go to your email box to see the reset email instructions."
      redirect_to new_reset_password_path
    else
      flash[:danger] = "User with this email (#{email}) is not registered."
      redirect_to new_reset_password_path
    end
  end

  def edit
    email = URI.decode(params[:email])
    token_id = params[:id]
    validate_and_expire_token(email, token_id)
    @new_token = ResetPassword.generate_token(email)
    @email = email
  end

  def update
    email = URI.decode(params[:email])
    token_id = params[:id]
    validate_and_expire_token(email, token_id)
    password = params[:password]

    user = User.find_by(email: email)
    user.password = password
    user.save

    flash[:notice] = "Password changed."
    redirect_to login_path
  end

  private

  def validate_and_expire_token(email, token_id)
    token = ResetPassword.where(token: token_id, email: email).first
    if token.nil?
      flash[:danger] = "Token has expired!"
      redirect_to login_path
      return
    end
    token.destroy
  end
end
