FactoryBot.define do
  factory :default, class: User do
    name {Faker::TvShows::FamilyGuy.character}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    email {Faker::Internet.email}
    password_digest {password = Faker::Internet.password}
    role { 0 }
    # association :merchant, factory: :random_merchant
  end
  factory :merchant_admin, class: User do
    name {Faker::TvShows::FamilyGuy.character}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    email {Faker::Internet.email}
    password {password = Faker::Internet.password}
    role { 1 }
    # association :merchant, factory: :random_merchant
    end
  factory :admin, class: User do
    name {Faker::TvShows::FamilyGuy.character}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    email {Faker::Internet.email}
    password {password = Faker::Internet.password}
    role { 2 }
    # association :merchant, factory: :random_merchant
    end
end