require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  it { should validate_presence_of :rating }
  it { should validate_presence_of :body}

  it "creates review" do
    create(:review)
    expect(Review.count).to eq(1)
  end

end
