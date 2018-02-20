require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to(:category) }

  it 'save itself' do
    category = Category.create(name: 'Comedy')
    video = Video.create(title: 'Movie3', category: category)
    expect(Video.first).to eql(video)
    expect(Video.count).to be(1)
    expect(Category.count).to be(1)
  end

  it "video's and categories are deleted" do
    expect(Video.count).to be(0)
    expect(Category.count).to be(0)
  end
end
