# frozen_string_literal: true

class User < ApplicationRecord
  # Authentication plugin bcrypt
  has_secure_password

  before_save { email.downcase! }

  validates :first_name,
            presence: true,
            length:   { maximum: 50 }

  validates :last_name,
            presence: true,
            length:   { maximum: 50 }

  validates :username,
            presence:   true,
            uniqueness: { case_sensitive: false },
            length:     { maximum: 50 }

  validates :email,
            presence:   true,
            uniqueness: true,
            length:     { maximum: 255 },
            format:     {
              with:        URI::MailTo::EMAIL_REGEXP,
              allow_blank: false,
            }

  validates :phone_number,
            presence: true

  validates :password,
            presence: true,
            length:   { minimum: 6 }
end
