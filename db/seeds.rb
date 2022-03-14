# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  # Create a main sample user.
  User.create!(name: 'Example User',
               email: 'user@example.org',
               password: 'password',
               password_confirmation: 'password')

  # Create an admin sample user.
  User.create!(name: 'Admin',
               email: 'admin@example.org',
               password: 'password',
               password_confirmation: 'password',
               admin: true)

  # Generate additional users.
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n + 1}@example.org"
    password = 'password'
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end

  random = Random.new

  User.all.each do |user|
    random.rand(0..20).times do
      user.link_post.create!(link_text: Faker::Lorem.paragraph_by_chars(number: random.rand(25..75)),
                             content: Faker::Lorem.paragraph_by_chars(number: random.rand(50..500)),
                             link: Faker::Internet.url)
    end
  end
end
