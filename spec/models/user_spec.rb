# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build :user }

  # Verifying if objects are created with unique attributes (email and username)
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }

  # Verifying user creation
  ##  when user is valid
  it { expect(user).to be_valid }
  it { is_expected { create :user }.to be_valid }

  # Verifying if object attribute presence is functional

  ## when first name is not present
  it { is_expected.to validate_presence_of :first_name }

  ## when last name is not present
  it { is_expected.to validate_presence_of :last_name }

  ## when username is not present
  it { is_expected.to validate_presence_of :username }

  ## when email is not present
  it { is_expected.to validate_presence_of :email }

  ## when phone number is not present
  it { is_expected.to validate_presence_of :phone_number }

  # Verifying length of object attribute

  ## when first name is too long
  it { is_expected.not_to validate_length_of(:first_name).is_at_most(51) }

  ## when last name is too long
  it { is_expected.not_to validate_length_of(:last_name).is_at_most(51) }

  ## when username is too long
  it { is_expected.not_to validate_length_of(:last_name).is_at_most(16) }

  ## when email is too long
  it { is_expected.not_to validate_length_of(:last_name).is_at_most(256) }

  # BCrypt Authentication

  ## password should have a minimum length
  describe "#password" do
    subject(:user) { described_class.new }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_confirmation_of(:password) }
  end

  # Verifying format of object attributes
  context "when email validation is valid" do
    let(:emails) do
      %w[
        USER@foo.COM
        THE_US-ER@foo.bar.org
        first.last@foo.jp
        alice+bob@baz.cn
      ]
    end

    let(:users) do
      emails.map do |email|
        create :user, email: email
      end
    end

    it { expect(users).to be_all(&:valid?) }
  end

  context "when email validation is not valid" do
    subject(:user) { create :user }

    invalid_addresses = %w[
      USER@foo,COM
      user_at_foo.org
      user.name@example
      foo@bar+baz.com
    ]

    invalid_addresses.each do |valid_address|
      before { user.email = valid_address }

      it { expect(user).not_to be_valid }
    end
  end

  context "when email address should be saved as lowercase" do
    subject(:user) { create :user, email: email }

    let(:email) { "Foo@ExAMPle.CoM" }

    it { expect(user.email).to eq(email.downcase) }
  end
end
