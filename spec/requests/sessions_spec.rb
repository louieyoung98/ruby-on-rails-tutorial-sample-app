# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  subject { action && response }

  describe "GET /new" do
    let(:action) { get login_path }

    it { is_expected.to have_http_status(:success) }
  end
end
