require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:videos) }
  it { should validate_presence_of :name }

  it "has ordered Categories by name" do
    comedy = Category.create(name: 'Comedy')
    action = Category.create(name: 'Action')
    science_fiction = Category.create(name: 'Science Fiction')

    expect(Category.all_asc).to eq([action, comedy, science_fiction])
  end

  it "gets ordered videos by title" do
    category = Category.create(name: 'Comedy')
    z_team = Video.create(title: "Z-Team", description: "some large description")
    a_team = Video.create(title: "A-Team", description: "some large description")
    b_team = Video.create(title: "B-Team", description: "some large description")
    category.videos << z_team
    category.videos << a_team
    category.videos << b_team

    expect(category.videos).to eq([a_team, b_team, z_team])
  end

  describe "#recent_videos" do
    it "displays only 6 recent videos" do
      category = Category.create(name: 'Comedy')
      10.times do |i|
        category.videos << Video.create(title: "Title#{i}", description: "some description")
      end
      expect(category.recent_videos.count).to eq(6)
    end

    it "videos are displayed from newest to oldest" do
      category = Category.create(name: 'Comedy')
      10.times do |i|
        category.videos << Video.create(title: "Title#{i}", description: "some description", created_at: i.days.ago, updated_at: i.days.ago)
      end
      # these videos are ordered by newest first
      videos = category.videos.order(updated_at: :desc)
      expect(category.recent_videos[0..2]).to eq([videos.first, videos.second, videos.third])
    end
    it "shows just videos of one category and omits for other category"
  end
end
