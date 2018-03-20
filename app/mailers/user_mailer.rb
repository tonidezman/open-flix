class UserMailer < ApplicationMailer
  default from: 'toni.dezman@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to OpenFlix #{@user.full_name}")
  end
end
