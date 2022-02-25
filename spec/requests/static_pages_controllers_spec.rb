require 'rails_helper'


RSpec.describe StaticPagesController, type: :request do
  subject { action && response }

  describe "GET /" do
    let(:action) { get root_path }
    it { is_expected.to have_http_status(:success) }
  end

  describe "GET #home" do
    let(:action) { get home_path }
    it { is_expected.to have_http_status(:success) }
  end

  describe "GET #help" do
    let(:action) { get help_path }
    it { is_expected.to have_http_status(:success) }
  end

  describe "GET #about" do
    let(:action) { get about_path }
    it { is_expected.to have_http_status(:success) }
  end

  describe "GET #contact" do
    let(:action) { get contact_path }
    it { is_expected.to have_http_status(:success) }
  end
end
