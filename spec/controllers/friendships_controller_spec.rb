require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  describe "GET #index" do
    it "returns http success if user is signed in" do
      create_user_and_login
      get :index
      expect(response).to have_http_status(:success)
    end

    it "redirects the user if he is not signed in" do
      get :index
      expect(response).to redirect_to(landing_page_path)
    end
  end

  describe "POST #create_friendship" do
    it "creates friendship" do
      create_user_and_login
      friend = create(:user)
      expect(Friendship.count).to eq(0)
      post :create_friendship, params: { id: friend.id }
      expect(Friendship.count).to eq(1)
    end

    it "prevents other users to create friendships for other users" do
      user = create(:user)
      friend = create(:user)
      expect(Friendship.count).to eq(0)
      post :create_friendship, params: { user: user, id: friend.id }
      expect(Friendship.count).to eq(0)
    end
  end

  describe "DELETE #destroy" do
    it "deletes friendships" do
      create_user_and_login
      friend = create(:user)
      create(:friendship, user_id: current_user.id, friend_id: friend.id)
      expect(Friendship.count).to eq(1)
      delete :destroy, params: { id: friend.id }
      expect(Friendship.count).to eq(0)
    end

    it "does not delete friendship for other users" do
      create_user_and_login
      other_user = create(:user)
      friend = create(:user)
      create(:friendship, user_id: other_user.id, friend_id: friend.id)
      expect(Friendship.count).to eq(1)
      delete :destroy, params: { id: friend.id }
      expect(Friendship.count).to eq(1)
    end

    it "un authenticated users are redirected" do
      other_user = create(:user)
      friend = create(:user)
      create(:friendship, user_id: other_user.id, friend_id: friend.id)
      expect(Friendship.count).to eq(1)
      delete :destroy, params: { user: other_user, id: friend.id }
      expect(Friendship.count).to eq(1)
    end
  end
end
