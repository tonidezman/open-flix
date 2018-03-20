require 'rails_helper'

RSpec.describe ResetPassword, type: :model do

  describe "#self.generate_token" do
    it "generate new email/token row if no email/token exist" do
      user = create(:user)
      expect(ResetPassword.count).to eq(0)
      ResetPassword.generate_token(user.email)
      expect(ResetPassword.count).to eq(1)
    end

    it "updates email/token record if email is already present" do
      user = create(:user)
      create(:reset_password, email: user.email, token: 'xxxxxxxxxxxxx')
      expect(ResetPassword.count).to eq(1)
      ResetPassword.generate_token(user.email)
      expect(ResetPassword.count).to eq(1)
    end
  end

end
