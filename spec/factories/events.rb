FactoryBot.define do
  factory :event do
    association :user
    title { 'bbq' }
    address { 'Moscow' }
    datetime { Time.parse('2017.10.09, 10:00') }
  end
end
