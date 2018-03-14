require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  describe "GET #index" do
    context "user is not authenticated" do
      it "redirects the user" do
        get :index
        expect(response).to redirect_to(landing_page_path)
      end
    end

    context "user is logged in" do
      it "returns http success" do
        create_user_and_login
        expect(response).to have_http_status(:success)
      end
    end
  end

end
