class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to OpenFlix #{@user.full_name}")
  end

  def reset_password_instruction(email, reset_url)
    @reset_url = reset_url
    mail(to: email, subject: "OpenFlix - Reset password instructions")
  end
end
