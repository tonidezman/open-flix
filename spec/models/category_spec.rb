require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:videos) }

  it "creates new Category" do
    category = Category.create(name: 'Comedy')
    expect(Category.count).to be(1)
  end

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

  it "does not create category without title" do
    Category.create(name: "")
    expect(Category.count).to be(0)
  end
end
