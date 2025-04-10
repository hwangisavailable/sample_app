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
  password_confirmation: "foobarfoobar"
)

User.create!(
  name:  "Banana Cat (happy)",
  email: "happihappi@happi.com",
  password:              "happihappi",
  password_confirmation: "happihappi"
)

User.create!(
  name:  "Banana Cat (sad)",
  email: "banana@cry4.com",
  password:              "banana@cry4.com",
  password_confirmation: "banana@cry4.com",
  admin: true,
)

# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end