# frozen_string_literal: true

class User < ApplicationRecord
  # Authentication plugin bcrypt
  has_secure_password

  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

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
            length:   { minimum: 6 },
            allow_nil: true

  scope :for_email_or_username, ->(value) do
    where(arel_table[:email].matches(value).or(arel_table[:username].matches(value))).limit(1)
  end

  scope :order_by_full_name, ->(direction = :asc) { order(first_name: direction) }

  scope :activated, -> { where.not(activated_at: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_account_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update(activated_at: Time.zone.now)
  end

  def activated?
    activated_at.present?
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

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
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

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
