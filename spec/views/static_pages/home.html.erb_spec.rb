# frozen_string_literal: true

require "rails_helper"

RSpec.describe "static_pages/home", type: :view do
  let(:user) { create :user }

  before do
    set_current_user user
    render template: "static_pages/home", layout: "layouts/application"
  end

  it "is home title" do
    expect(rendered).to have_title(full_title)
  end
end
