# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name[0..49] }
    last_name { Faker::Name.last_name[0..49] }
    username { Faker::Internet.unique.username[0..14] }
    password { "test_password" }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    email { "#{first_name}.#{last_name}@example.com" }
    activation_token { User.new_token }
    activated_at { Time.zone.now }
  end
end
