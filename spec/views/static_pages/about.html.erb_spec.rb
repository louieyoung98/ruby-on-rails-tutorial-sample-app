require 'rails_helper'

RSpec.describe 'static_pages/about', type: :view do
  before do
    render template: 'static_pages/about', layout: 'layouts/application'
  end

  it 'is about title' do
    expect(rendered).to have_title(full_title(t('static_pages.about.title')))
  end
end
