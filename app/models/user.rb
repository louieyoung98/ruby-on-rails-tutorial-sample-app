# frozen_string_literal: true

class User < ApplicationRecord
  # Authentication plugin bcrypt
  has_secure_password

  attr_accessor :remember_token

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

  scope :for_email_or_username, ->(value) do
    where(arel_table[:email].matches(value).or(arel_table[:username].matches(value))).limit(1)
  end

  def remember
    self.remember_token = User.new_token

    digest = User.digest(remember_token)
    update_attribute(:remember_digest, digest)

    digest
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def session_token
    remember_digest || remember
  end

  class << self
    # Query Class methods
    def find_by_email_or_username(value)
      for_email_or_username(value).first
    end

    # Class methods
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
