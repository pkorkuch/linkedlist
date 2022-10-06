FactoryBot.define do
  factory :bookmark do
    association :user, :activated
    link_post
  end
end
