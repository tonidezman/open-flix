require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects the user if she is logged in" do
      create_user_and_login
      get :new
      expect(response).to redirect_to(home_path)
    end
  end

  describe "POST #create" do
    it "redirects the user if data is valid" do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to redirect_to(home_path)
    end

    it "creates new user" do
      post :create, params: { user: attributes_for(:user) }
      expect(User.count).to eq(1)
    end

    it "does not create user" do
      post :create, params: { user: {"email"=>"tonko@balonko.com", "password"=>"", "full_name"=>"Tonko Balonko"}}
      expect(User.count).to eq(0)
    end

    it "renders new if user data is invalid" do
      post :create, params: { user: {"email"=>"", "password"=>"secret password", "full_name"=>""}}
      expect(response).to have_http_status(:success)
    end

    describe "Sends out email" do
      fit "sends email" do
        post :create, params: { user: attributes_for(:user) }
        sleep(1)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end

  describe "GET #show" do
    it "shows user info" do
      create_user_and_login
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it "redirects user that is not logged in" do
      user = create(:user)
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to redirect_to landing_page_path
    end
  end

end
