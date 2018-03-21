FactoryBot.define do
  factory :user do
    full_name Faker::Name.name
    sequence(:email) { |n| "person#{n}@example.com" }
    password Faker::Lorem.characters(10)
    is_admin false
  end
end