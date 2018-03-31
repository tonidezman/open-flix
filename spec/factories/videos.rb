FactoryBot.define do
  factory :video do
    category
    title Faker::Lorem.sentence(5)
    description Faker::Lorem.paragraph(3)
    large_cover '/tmp/monk_large.jpg'
    small_cover '/tmp/monk.jpg'
  end
end