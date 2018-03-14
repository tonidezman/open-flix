require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:reviews) }
  it { should have_one(:queue_item) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }

  it 'save itself' do
    category = Category.create(name: 'Comedy')
    video = Video.create(title: 'Movie', description: "some description", category: category)
    expect(Video.first).to eql(video)
    expect(Video.count).to be(1)
    expect(Category.count).to be(1)
  end

  it "video's and categories are deleted" do
    expect(Video.count).to be(0)
    expect(Category.count).to be(0)
  end

  describe "#current_user_rating" do
    it "returns rating of current user" do
      user = create(:user)
      video = create(:video)
      review = create(:review, user: user, video: video)
      expected = review.rating
      actual = video.current_user_rating(user)
      expect(actual).to eq(expected)
    end

    it "does not return other user ratings" do
      user_1 = create(:user, email: 'user1@example.com')
      user_2 = create(:user, email: 'user2@example.com')
      video = create(:video)
      review_1 = create(:review, user: user_1, video: video)
      review_2 = create(:review, user: user_2, video: video)
      expected = review_1.rating
      actual = video.current_user_rating(user_1.id)
      expect(actual).to eq(expected)
    end

    it "returns 99 if there is no rating" do
      user = create(:user)
      video = create(:video)
      expected = 0
      actual = video.current_user_rating(user)
      expect(actual).to eq(expected)
    end
  end

  describe "#search_by_title" do

    it "returns empty array" do
      search_result = Video.search_by_title("family")
      expect(search_result.empty?).to be(true)
    end

    it "returns one result" do
      category = Category.create(name: 'Comedy')
      Video.create(title: 'Movie', description: "some description", category: category)
      Video.create(title: 'Movie2', description: "some description", category: category)
      search_result = Video.search_by_title("movie2")
      expect(search_result.count).to be(1)
    end

    it "returns multiple results" do
      category = Category.create(name: 'Comedy')
      Video.create(title: 'Movie', description: "some description", category: category)
      Video.create(title: 'Movie2', description: "some description", category: category)
      Video.create(title: 'barbie', description: "some description", category: category)
      search_result = Video.search_by_title("movie")
      expect(search_result.count).to be(2)
    end

    it "return empty array if user's search term is empty string" do
      category = Category.create(name: 'Comedy')
      Video.create(title: 'Movie', description: "some description", category: category)
      Video.create(title: 'Movie2', description: "some description", category: category)
      Video.create(title: 'barbie', description: "some description", category: category)
      search_result = Video.search_by_title("")
      expect(search_result.empty?).to be(true)
    end
  end


  describe "#last_5_reviews" do
    it "returns list of reviews ordered newest first" do
      video = create(:video)
      user = create(:user)
      review_1 = create(:review, user: user, video: video)
      review_2 = create(:review, user: user, video: video)
      review_3 = create(:review, user: user, video: video)
      review_4 = create(:review, user: user, video: video)
      review_5 = create(:review, user: user, video: video)
      review_6 = create(:review, user: user, video: video)

      expect(video.last_5_reviews).to eq([review_6, review_5, review_4, review_3, review_2])
    end
  end

  describe "#average_review_score" do
    it "returns average review score" do
      user = create(:user)
      video = create(:video)
      create(:review, rating: 1, video: video, user: user)
      create(:review, rating: 2, video: video, user: user)
      create(:review, rating: 2, video: video, user: user)
      expect(video.average_review_score).to eq(1.7)
    end
  end
end
