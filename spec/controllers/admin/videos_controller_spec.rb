require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do

  describe "GET #new" do
    it "returns http success if user is logged in and admin" do
      create_admin_user_and_login
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects to landing page if user is not logged in" do
      get :new
      expect(response).to redirect_to(landing_page_path)
    end

    it "redirects to home path if user is not admin" do
      create_user_and_login
      get :new
      expect(response).to redirect_to(home_path)
    end
  end

end
