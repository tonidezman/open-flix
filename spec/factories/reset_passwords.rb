FactoryBot.define do
  factory :reset_password do
    token SecureRandom.hex(13)
    email Faker::Internet.email
  end
end
