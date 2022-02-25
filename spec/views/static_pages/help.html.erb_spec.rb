require 'rails_helper'

RSpec.describe 'static_pages/help', type: :view do
  before do
    render template: 'static_pages/help', layout: 'layouts/application'
  end

  it 'is about title' do
    assert_select 'title', 'Help | Ruby on Rails Tutorial Sample App'
  end
end