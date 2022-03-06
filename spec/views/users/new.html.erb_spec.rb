require "rails_helper"

RSpec.describe "users/new.html.erb", type: :view do
  let(:user) { create :user }

  before do
    render template: "users/new", layout: "layouts/application"
    assign :user, user
  end

  it "is new title" do
    expect(rendered).to have_title(full_title("Sign up"))
  end
end
