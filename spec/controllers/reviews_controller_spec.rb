require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe "POST #create" do
    let(:video) { create(:video) }
    before(:each) do
      create_user_and_login
    end

    it "creates new review" do
      expect(Review.count).to eq(0)
      post :create, params: { review: { rating: "5", body: "review text", video_id: video.id } }
      expect(Review.count).to eq(1)
      expect(response).to redirect_to(video)
    end

    it "does not create review if there is no rating" do
      post :create, params: { review: { rating: "", body: "review text", video_id: video.id } }
      expect(Review.count).to eq(0)
      expect(response).to have_http_status(:success)
    end

  end
end
