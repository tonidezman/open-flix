require "rails_helper"

RSpec.describe "User sign's in", :type => :system, js: true do
  let(:user) { create(:user) }

  xit "user signs up/register for our app" do
    video = create(:video, title: "Superman")
    3.times do
      create(:video)
    end

    visit login_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    expect(page).to have_content(user.full_name)

    click_on "OpenFlix"
    find("a[href*='/videos/#{video.id}'").click
    expect(page).to have_content(video.title)

    click_link "+ My Queue"
    expect(page).to have_content("My Queue")
    visit "videos/#{video.id}"
    expect(page).not_to have_content "+ My Queue"
  end
end
