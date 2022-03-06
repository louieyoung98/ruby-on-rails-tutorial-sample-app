# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.unique.username }
    password { "test_password" }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    email { "#{first_name}.#{last_name}@example.com" }
  end
end
