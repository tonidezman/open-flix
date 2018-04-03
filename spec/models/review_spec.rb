require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  it "creates review" do
    create(:review)
    expect(Review.count).to eq(1)
  end

  describe "#video_category" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:video) { create(:video, category: category) }
    let(:review) { create(:review, user: user, video: video) }

    it "returns video category object" do
      expected = review.video_category
      actual = Review.find_by(user: user, video: video).video.category
      expect(expected).to eq(actual)
    end
  end

  describe "#video_category_name" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:video) { create(:video, category: category) }
    let(:review) { create(:review, user: user, video: video) }

    it "returns video category name" do
      expected = review.video_category_name
      actual = Review.find_by(user: user, video: video).video.category.name
      expect(expected).to eq(actual)
    end
  end

end
