require 'rails_helper'

RSpec.describe FriendInvitationsController, type: :controller do

  describe "GET #new" do
    it "returns http success if logged in user" do
      create_user_and_login
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects to login landing page if user is not logged in" do
      get :new
      expect(response).to redirect_to(landing_page_path)
    end
  end

  describe "POST #create" do
    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it "does not send mail if friend is already registered" do
      create_user_and_login
      friend = create(:user)
      post :create, params: { friend_name: "Dadi", email: friend.email, invitation_text: "Hello my friend!" }
      sleep(1)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      expect(response).to redirect_to(new_friend_invitation_path)
    end

    it "it sends email to a friend and redirects to mail_was_send page" do
      create_user_and_login
      post :create, params: { friend_name: "Dadi", email: "friend@example.com", invitation_text: "Hello my friend!" }
      sleep(1)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(response).to redirect_to(mail_to_friend_was_sent_path)
    end

    it "it redirects to landing_page if user is not logged in" do
    end
  end

end
