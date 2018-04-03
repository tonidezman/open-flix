require 'rails_helper'

RSpec.describe ResetPasswordsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "redirects user to same page if email is not in database" do
      post :create , params: { email: 'nonexisting@example.com' }
      expect(response).to redirect_to(register_path)
    end

    it "sends email if email in database" do
      user = create(:user)
      post :create , params: { email: user.email }
      expect(response).to redirect_to(new_reset_password_path)
    end
  end

  describe "GET #edit" do
    it "redirects user if token is expired" do
      get :edit, params: { id: SecureRandom.hex(13), email: 'nonexisting@example.com' }
      expect(response).to redirect_to(login_path)
    end

    it "returns http success if token and email are valid" do
      user = create(:user)
      token_email_record = create(:reset_password, email: user.email)

      get :edit, params: { id: token_email_record.token, email: user.email,  }
      expect(response).to have_http_status(:success)
    end

    it "prevents users to change password from other users" do
      user = create(:user, full_name: "Toni Dezman", email: "toni@dezman.com", password: "password")
      other_user = create(:user, full_name: "Dadi Dezman", email: "dadi@dezman.com", password: "password")
      user_token = create(:reset_password, email: user.email, token: SecureRandom.hex(13))
      other_users_token = create(:reset_password, email: other_user.email, token: SecureRandom.hex(13))
      expect(ResetPassword.count).to eq(2)

      get :edit, params: { id: user_token.token, email: other_user.email,  }
      expect(ResetPassword.count).to eq(2)
    end
  end

  describe "PUT #update" do
    it "does not change password if invalid token/email" do
      old_password = "OldPassword"
      new_password = "NewPassword"
      user = create(:user, full_name: "Toni Dezman", email: "toni@dezman.com", password: old_password)
      token_email_record = create(:reset_password, email: user.email, token: SecureRandom.hex(13))

      get :update, params: { id: 'xxxxxxxxxxxxx', email: user.email, password: new_password }
      expect(user.reload.password).to eq(old_password)
    end

    it "redirects user if token is expired/invalid" do
      old_password = "OldPassword"
      new_password = "NewPassword"
      user = create(:user, full_name: "Toni Dezman", email: "toni@dezman.com", password: old_password)

      get :update, params: { id: 'xxxxxxxxxxxxx', email: user.email, password: new_password }
      expect(response).to redirect_to(login_path)
    end
  end
end
