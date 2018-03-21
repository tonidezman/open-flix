class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to OpenFlix #{@user.full_name}")
  end

  def reset_password_instruction(email, reset_url)
    @reset_url = reset_url
    mail(to: email, subject: "OpenFlix - Reset password instructions")
  end

  def friend_invitation(existing_user, friend_name, friend_email, invitation_text)
    @existing_user = existing_user
    @friend_name = friend_name
    @invitation_text = invitation_text
    mail(to: friend_email, subject: "Hi #{@friend_name}.")
  end
end
