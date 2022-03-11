# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create :user }
    let(:mail) { described_class.account_activation(user) }

    context "when rendering the headers" do
      it { expect(mail.subject).to eq("Account Activation") }
      it { expect(mail.to).to eq([user.email]) }
      it { expect(mail.from).to eq(["noreply@example.com"]) }
    end

    context "when rendering the body" do
      it { expect(mail.body.encoded).to match("Hi") }
    end
  end
end
