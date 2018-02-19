# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Deleting all Videos"
Video.destroy_all

Video.create(title: Faker::Name.name, description: Faker::Lorem.paragraph, small_cover_url: '/tmp/futurama.jpg')
Video.create(title: Faker::Name.name, description: Faker::Lorem.paragraph, small_cover_url: '/tmp/south_park.jpg')
Video.create(title: Faker::Name.name, description: Faker::Lorem.paragraph, small_cover_url: '/tmp/family_guy.jpg')
puts "Created #{Video.count} videos"