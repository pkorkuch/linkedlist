FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name { Faker::Name.name }
    email { generate(:email) }
    password { 'password' }

    trait :admin do
      admin { true }
    end

    trait :activated do
      activated_at { created_at + Random.new.rand(1..1000).minutes }
    end
  end
end
