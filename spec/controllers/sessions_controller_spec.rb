require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects logged in user" do
      create_user_and_login
      get :new
      expect(response).to redirect_to(home_path)
    end
  end

  describe "POST #create" do
    it "redirect to home_path if user is found" do
      user = create(:user)
      post :create, params: { email: user.email, password: user.password }
      expect(response).to redirect_to(home_path)
    end

    it "does not redirect user with incorrect data" do
      user = create(:user)
      post :create, params: { email: user.email, password: "password" }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do

    it "redirects logout user" do
      create_user_and_login
      get :destroy
      expect(response).to redirect_to(root_path)
    end

  end

end
