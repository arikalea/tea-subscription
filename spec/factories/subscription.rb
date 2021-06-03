FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { 15 }
    status {[:active, :cancelled].sample}
    frequency {[:two_weeks, :four_weeks, :six_weeks].sample}
    customer
  end
end
