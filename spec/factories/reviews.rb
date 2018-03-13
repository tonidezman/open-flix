FactoryBot.define do
  factory :review do
    user
    video
    rating [*1..5].sample
    body Faker::Lorem.paragraph(5)
  end
end
