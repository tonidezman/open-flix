class FriendshipsController < ApplicationController
  before_action :check_logged_in_or_redirect

  def index
    @friends = current_user.friends
  end

  def create_friendship
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:id])
    not_the_same_person = current_user.id.to_i != params[:id].to_i
    if not_the_same_person && friendship.save
      redirect_to friendships_path, notice: "Friend added!"
    else
      flash[:danger] = "Something went wrong!"
      redirect_to current_user
    end
  end

  def destroy
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    friendship&.destroy
    redirect_to friendships_path, notice: "Friendship successfully deleted!"
  end

end
