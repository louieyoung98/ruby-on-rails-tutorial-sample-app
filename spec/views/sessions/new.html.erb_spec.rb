# frozen_string_literal: true

require "rails_helper"

RSpec.describe "sessions/new.html.erb", type: :view do
  let(:user) { create :user }

  before do
    set_current_user user
    assign :user, user

    render template: "sessions/new", layout: "layouts/application"
  end

  describe "when user is on log in page" do
    it "has log in title" do
      expect(rendered).to have_title(full_title("Log in"))
    end
  end
end
