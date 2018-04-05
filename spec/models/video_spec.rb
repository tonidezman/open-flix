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

  describe "#not_yet_queued?" do
    it "returns false if video is not yet queued" do
      user = create(:user)
      video = create(:video)
      expect(video.not_yet_queued?(user)).to eq(true)
    end

    it "return true if video is queued" do
      user = create(:user)
      video = create(:video)
      create(:queue_item, user: user, video: video)
      expect(video.not_yet_queued?(user)).to eq(false)
    end

    it "other users do not get interfered when user queues an item" do
      other_user = create(:user)
      user = create(:user)
      video = create(:video)
      create(:queue_item, user: user, video: video)
      expect(video.not_yet_queued?(other_user)).to eq(true)
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
end
