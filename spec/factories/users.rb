FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "user#{n}" } 
    password { '123123' }
    password_confirmation { '123123' }
  end
end
