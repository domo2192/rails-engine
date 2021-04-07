require "faker"
FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
    description { Faker::Name.unique.name }
    unit_price { 10 }
    merchant
  end
end
