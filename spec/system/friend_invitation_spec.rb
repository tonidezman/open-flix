require "rails_helper"

RSpec.describe "User sign's in", :type => :system, js: true do
  let(:existing_user) { create(:user, full_name: "Toni Dezman", email: "toni@dezman.com") }

  xit "checks if both user follow each other when existing user invites a friend" do
    extend Capybara::Email::DSL
    clear_emails
    existing_user_logs_in
    click_link "Welcome, #{existing_user.full_name}"
    click_link "Invite a Friend"

    fill_in "Friends' Name", with: "John Friend"
    friends_email = "john_friend@example.com"
    fill_in "Friend's Email Address", with: friends_email
    click_on "Send Invitation"
    expect(page).to have_content("Mail to your Friend was sent.")
    existing_user = User.find_by(email: 'toni@dezman.com')
    logout(existing_user)

    open_email(friends_email)
    current_email.click_link 'Click here to register'
    expect(page).to have_content('Register')

    fill_in "Email Address", with: "john_friend@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Friend"
    click_on "Sign Up"
    click_link "People"
    expect(page).to have_content("Toni Dezman")

    new_user = User.find_by(email: "john_friend@example.com")
    logout(new_user)
    existing_user_logs_in
    click_link "People"
    expect(page).to have_content("John Friend")
    clear_emails
  end

  private

  def logout(user)
    click_link "Welcome, #{user.full_name}"
    click_link "Sign Out"
  end

  def existing_user_logs_in
    visit login_path
    fill_in "Email Address", with: existing_user.email
    fill_in "Password", with: existing_user.password
    click_on "Log in"
  end
end

