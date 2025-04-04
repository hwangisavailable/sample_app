# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a main sample user.
User.create!(
  name:  "Mr. Author",
  email: "example@railstutorial.org",
  password:              "foobarfoobar",
  password_confirmation: "foobarfoobar",
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name:  "Banana Cat (happy)",
  email: "happihappi@happi.com",
  password:              "happihappi",
  password_confirmation: "happihappi",
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name:  "Banana Cat (sad)",
  email: "banana@cry4.com",
  password:              "banana@cry4.com",
  password_confirmation: "banana@cry4.com",
  activated: true,
  activated_at: Time.zone.now,
  admin: true,
)

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

# Create microposts for each user
User.find_each do |user|
  # Create a number of posts for each user
  rand(1..3).times do
    content = Faker::Lorem.sentence(word_count: rand(5..15))  # Random content for the post
    user.microposts.create!(content: content)
  end
end

# Users 1 to 10 (IDs 1 to 10) will follow between 0 to 10 users randomly
User.where(id: 1..10).find_each do |user|
  following_count = rand(0..10)
  # Now, sample from ALL users, excluding the current user
  following = User.where.not(id: user.id).sample(following_count)

  following.each do |followed_user|
    user.follow(followed_user) unless user.following.include?(followed_user)
  end
end

# Users greater than 10 (user IDs 11 and beyond) should follow users 1 to 10
User.where("id > 10").find_each do |user|
  following_count = if rand < 0.5
                      rand(8..10)  # 50% chance to follow between 8 and 10 users
                    else
                      rand(0..7)  # Otherwise follow between 0 and 7 users
                    end

  # Randomly select users from the list of users 1 to 10
  following = User.where(id: 1..10).sample(following_count)

  following.each do |followed_user|
    user.follow(followed_user) unless user.following.include?(followed_user)
  end
end