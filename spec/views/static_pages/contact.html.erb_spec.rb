require 'rails_helper'

RSpec.describe 'static_pages/contact', type: :view do
  before do
    render template: 'static_pages/contact', layout: 'layouts/application'
  end

  it 'is contact title' do
    assert_select 'title', 'Contact | Ruby on Rails Tutorial Sample App'
  end
end