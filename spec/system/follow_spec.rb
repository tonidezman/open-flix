require "rails_helper"

RSpec.describe "User follows other users", :type => :system, js: true do
    let!(:user) { create(:user, email: 'toni@example.com', password: 'password', full_name: 'Tonko Balonko') }
    let!(:other_user) { create(:user, email: 'dadi@example.com', password: 'password', full_name: 'Klavdija Dadi') }

  it "follows and unfollows other user" do
    video = create(:video, title: "Superman")
    create(:review, video: video, user: other_user)

    visit root_path
    click_link "Log in"

    fill_in "Email Address", with: "toni@example.com"
    fill_in "Password", with: "password"
    click_on "Log in"
    expect(page).to have_content('Tonko Balonko')

    find("a[href*='videos/#{video.id}'").click
    expect(page).to have_content(video.title)

    find("a[href*='users/#{other_user.id}'").click
    expect(page).to have_content("#{other_user.full_name}'s video collections")

    click_link "Follow"
    expect(page).to have_content("People I Follow")
    expect(page).to have_content(other_user.full_name)

    find("a[href*='friendships/#{other_user.id}'").click
    expect(page).not_to have_content(other_user.full_name)
  end
end
