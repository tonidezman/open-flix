require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  describe "GET #index" do
    it "redirects if user not loged in" do
      get :index
      expect(response).to redirect_to(landing_page_path)
    end

    it "returns http success" do
      user = create(:user)
      login(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before(:all) do
    end

    it "return http success" do
      user = create(:user)
      video = create(:video)
      login(user)
      get :show, params: { id: video.id }
      expect(response).to have_http_status(:success)
    end
  end

end
