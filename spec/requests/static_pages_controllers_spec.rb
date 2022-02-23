require 'rails_helper'

RSpec.describe 'StaticPagesControllers', type: :request do
  subject { action && response }

  describe "GET #home" do
    let(:action) { get home_path }
    it { is_expected.to have_http_status(:success)}
  end

  describe "GET #help" do
    let(:action) { get help_path }
    it { is_expected.to have_http_status(:success)}
  end

  describe "GET #about" do
    let(:action) { get about_path }
    it { is_expected.to have_http_status(:success)}
  end
end
