# frozen_string_literal: true

require "rails_helper"

RSpec.describe "users/new.html.erb", type: :view do
  let(:user) { create :user }

  before do
    set_current_user user
    assign :user, user

    render template: "users/new", layout: "layouts/application"
  end

  it "is new title" do
    expect(rendered).to have_title(full_title("Sign up"))
  end
end
