require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:videos) }

  it "creates new Category" do
    category = Category.create(name: 'Comedy')
    expect(Category.count).to be(1)
  end
end
