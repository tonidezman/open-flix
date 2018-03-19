require "rails_helper"

RSpec.describe "User sign's in", :type => :system, js: true do

  it "user signs up/register for our app" do
    visit root_path
    expect(page).to have_content("Sign Up Now")

    click_link "Sign Up Now!"

    fill_in "Email Address", with: "john@doe.com"
    fill_in "Password", with: "my password"
    fill_in "Full Name", with: "John Doe"
    click_on "Sign Up"

    expect(page).to have_content("John Doe")
  end
end