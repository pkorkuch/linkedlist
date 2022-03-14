FactoryBot.define do
  factory :link_post do
    link_text { Faker::Lorem.paragraph_by_chars number: Random.new.rand(25..75) }
    content { Faker::Lorem.paragraph_by_chars number: Random.new.rand(50..500) }
    link { Faker::Internet.url }
    user
  end
end
