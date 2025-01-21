# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

User.destroy_all
Show.destroy_all
Schedule.destroy_all
ScheduleShow.destroy_all

STAGES = ["Main Stage", "Side Stage", "VIP Stage", "Electronic Stage"]

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email
  )
end

20.times do
  Show.create!(
    artist: Faker::Music.band,
    location: STAGES.sample,
    date: Date.today,
    time: Time.new(
      Date.today.year,
      Date.today.month,
      Date.today.day,
      rand(13..23),
      [0, 30].sample,
      0,
      Time.zone.name
    )
  )
end

User.all.each do |user|
  schedule = Schedule.create!(
    title: "#{user.first_name}'s Schedule",
    date: Date.today,
    user: user
  )

  Show.all.sample(5).each do |show|
    ScheduleShow.create!(schedule: schedule, show: show)
  end
end