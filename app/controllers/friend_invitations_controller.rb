class FriendInvitationsController < ApplicationController
  before_action :check_logged_in_or_redirect

  def new
  end

  def create
    UserMailer.friend_invitation(current_user, params[:friend_name], current_user.email, params[:invitation_text]).deliver_now
    redirect_to mail_to_friend_was_sent_path

    # user = User.find_by(email: params[:email])
    # if user
    #   flash[:danger] = "User #{params[:friend_name]} (#{user.full_name}) is already registered."
    #   redirect_to new_friend_invitation_path
    #   return
    # end

    # UserMailer.friend_invitation(current_user, params[:friend_name], params[:email], params[:invitation_text]).deliver_later
    redirect_to mail_to_friend_was_sent_path
  end

  def mail_was_sent
  end
end
