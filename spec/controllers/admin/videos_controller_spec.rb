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

  describe "POST #create" do
    context "user is authenticated and authorized" do
      before(:each) do
        create_admin_user_and_login
      end

      it "creates video if data is valid" do
        category = create(:category)
        post :create, params: { video: { title: 'new Video', category_id: category.id, description: 'lorem'} }
        expect(Video.count).to eq(1)
      end

      it "does not create video if data is not valid" do
        post :create, params: { video: { title: "some title" } }
        expect(Video.count).to eq(0)
      end
    end

    it "redirects the user if he is not admin" do
      create_user_and_login
      post :create, params: { video: { title: "some title" } }
      expect(response).to redirect_to(home_path)
    end

    it "redirects the user if he is not logged in" do
      post :create, params: { video: { title: "some title" } }
      expect(response).to redirect_to(landing_page_path)
    end
  end

end
