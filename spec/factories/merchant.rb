FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name {Faker::Superhero.power}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
  end
end
