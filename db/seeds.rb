require 'faker'
require 'factory_bot_rails'

puts "Deleting data"
Category.destroy_all
QueueItem.destroy_all
User.destroy_all
Review.destroy_all
Video.destroy_all

puts
puts "Generating data"
puts

puts "Generating Category"
comedy = FactoryBot.create(:category, name: 'Comedy')
drama = FactoryBot.create(:category, name: 'Drama')
action = FactoryBot.create(:category, name: 'Action')

puts
puts "Generating Videos"
10.times do |index|
  FactoryBot.create(:video, title: "Futurama #{index}", small_cover_url: '/tmp/futurama.jpg', category: comedy)
  FactoryBot.create(:video, title: "South Park #{index}", small_cover_url: '/tmp/south_park.jpg', category: drama)
  FactoryBot.create(:video, title: "Family Guy #{index}", small_cover_url: '/tmp/family_guy.jpg', category: action)
  FactoryBot.create(:video, title: "Monk #{index}", small_cover_url: '/tmp/monk.jpg', category: action)
end

puts
puts "Creating Users"
7.times do
  FactoryBot.create(:user, full_name: Faker::Name.name)
end

puts
puts "Following other users"
User.all.each do |user|
  if [true, false].sample
    user.friends << User.all[[*0..6].sample]
  end
end

puts
puts "Users are rating videos now :)"
User.all.each do |user|
  Video.all.each do |video|
    FactoryBot.create(:review, user: user, video: video, rating: [*1..5].sample)
  end
end


puts
puts "Users are adding videos to their queue"
User.first(5).each do |user|
  Video.all.each do |video|
    FactoryBot.create(:queue_item, user: user, video: video)
  end
end

puts
puts "*************************"
puts "Created #{Category.count} categories"
puts "Created #{User.count} users"
puts "Created #{Friendship.count} friendships"
puts "Created #{Video.count} videos"
puts "Created #{Review.count} reviews"
puts "Created #{QueueItem.count} queueItems"
puts "*************************"
