require 'rails_helper'

RSpec.describe 'static_pages/home', type: :view do
  before do
    render template: 'static_pages/home', layout: 'layouts/application'
  end

  it 'is home title' do
    assert_select 'title', 'Home | Ruby on Rails Tutorial Sample App'
  end
end