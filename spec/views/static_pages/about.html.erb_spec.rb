require 'rails_helper'

RSpec.describe 'static_pages/about', type: :view do
  before do
    render template: 'static_pages/about', layout: 'layouts/application'
  end

  it 'is about title' do
    assert_select 'title', 'About | Ruby on Rails Tutorial Sample App'
  end
end