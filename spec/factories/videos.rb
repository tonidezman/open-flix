FactoryBot.define do
  factory :video do
    category
    title Faker::Lorem.sentence(5)
    description Faker::Lorem.paragraph(3)
  end
end