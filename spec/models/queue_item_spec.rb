require 'rails_helper'

RSpec.describe QueueItem, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:video)}

  describe "#video_title" do
    it "returns video title" do
      user = create(:user)
      video = create(:video, title: 'Heman')
      queue_item = create(:queue_item, user: user, video: video)
      expect(queue_item.video_title).to eq('Heman')
    end
  end

  describe "#normalize_positions" do
    it "correctly reorders queue items" do
      user = create(:user)
      queue_item_1 = create(:queue_item, user: user, position: 2)
      queue_item_2 = create(:queue_item, user: user, position: 5)
      queue_item_3 = create(:queue_item, user: user, position: 9)
      QueueItem.normalize_positions([queue_item_1, queue_item_2, queue_item_3])
      expect(queue_item_1.reload.position).to eq(1)
      expect(queue_item_2.reload.position).to eq(2)
      expect(queue_item_3.reload.position).to eq(3)
    end
  end

  describe "#is_valid_number" do
    it "raises ArgumentError if it is invalid number" do
      queue_item = create(:queue_item)
      expect{queue_item.is_valid_number("3tonko")}.to raise_error(ArgumentError)
    end

    it "does not raise Argument error if number is positive integer" do
      queue_item = create(:queue_item)
      expect{queue_item.is_valid_number("3")}.not_to raise_error
    end
  end

  describe "#rating" do
    it "returns review rating" do
      user = create(:user)
      video = create(:video)
      create(:review, video: video, user: user, rating: 3)
      queue_item = create(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(3)
    end

    it "returns 0 if there is no rating" do
      user = create(:user)
      video = create(:video)
      queue_item = create(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(0)
    end
  end

  describe "#category_name" do
    it "returns category name" do
      user = create(:user)
      category = create(:category, name: "comedy")
      video = create(:video, category: category)
      queue_item = create(:queue_item, user: user, video: video)
      expect(queue_item.category_name).to eq("comedy")
    end
  end

  describe "#category" do
    it "returns category" do
      user = create(:user)
      category = create(:category, name: "comedy")
      video = create(:video, category: category)
      queue_item = create(:queue_item, user: user, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end
