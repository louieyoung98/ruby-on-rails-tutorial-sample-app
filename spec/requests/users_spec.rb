require 'rails_helper'

RSpec.describe User, type: :request do
  subject { action && response }

  describe "GET #new" do
    let(:action) { get root_path }
    it { is_expected.to have_http_status(:success) }
  end
end
