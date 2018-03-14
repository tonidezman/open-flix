require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }

  describe "#next_queue_item_order_num" do
    it "returns 1 if there are no queue items" do
      user = create(:user)
      expect(user.next_queue_item_order_num).to eq(1)
    end

    it "returns next order number in queue item" do
      user = create(:user)
      create(:queue_item, user: user, position: 1)
      expect(user.next_queue_item_order_num).to eq(2)
    end

    it "returns next order number, counting from the last item in queue item" do
      user = create(:user)
      create(:queue_item, user: user, position: 7)
      expect(user.next_queue_item_order_num).to eq(8)
    end

    it "returns 99 if last item has no order number" do
      user = create(:user)
      create(:queue_item, user: user, position: nil)
      expect(user.next_queue_item_order_num).to eq(99)
    end
  end
end
