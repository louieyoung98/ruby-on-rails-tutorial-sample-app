# spec/requests/static_pages_controllers_spec.rb
require 'rails_helper'

RSpec.describe 'StaticPagesControllers', type: :request do
  # Optional (but recommended) approach, as seen in #Test 1 Example
  subject { action && response }

  # Test 1 Example (Utilising subject for shorthand)
  describe "GET #home" do
    let(:action) { get home_path }
    it { is_expected.to be_successful }
  end

  # Test 2 Example (Longhand without utilising subject)
  describe "GET #help" do
    it "is successful" do
      get help_path
      expect(response).to be_successful
      assert_select 'title', 'Help | Ruby on Rails Tutorial Sample App'
    end
  end

  # Test 3 Example (Utilising subject for shorthand)
  describe "GET #about" do
    let(:action) { get about_path }
    it { is_expected.to be_successful }
  end
end
