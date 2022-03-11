# frozen_string_literal: true

require "rails_helper"

RSpec.describe "static_pages/about", type: :view do
  let(:user) { create :user }

  before do
    set_current_user user
    render template: "static_pages/about", layout: "layouts/application"
  end

  it "is about title" do
    expect(rendered).to have_title(full_title(t("static_pages.about.title")))
  end
end
