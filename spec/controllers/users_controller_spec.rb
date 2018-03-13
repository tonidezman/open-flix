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
  end

end
