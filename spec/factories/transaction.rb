require "faker"
FactoryBot.define do
  factory :transaction do
  credit_card_number {Faker::Business.credit_card_number.to_s}
  credit_card_expiration_date { "04/23" }
   result { "success" }

  end
end
