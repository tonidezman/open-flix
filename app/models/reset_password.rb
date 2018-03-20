class ResetPassword < ApplicationRecord

  def self.generate_token(email)
    token_email = find_by(email: email)
    new_token = nil
    if token_email
      new_token = create_token
      token_email.token = new_token
      token_email.save
    else
      new_token = create_token
      create(email: email, token: new_token)
    end
    new_token
  end

  private

  def self.create_token
    SecureRandom.hex(13)
  end
end
