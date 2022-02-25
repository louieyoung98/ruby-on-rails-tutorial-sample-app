# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    username { "MyString" }
    password_hash { "MyString" }
    phone_number { "MyString" }
    email { "MyString" }
  end
end
