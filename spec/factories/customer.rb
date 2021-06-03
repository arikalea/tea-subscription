FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
  end
end
