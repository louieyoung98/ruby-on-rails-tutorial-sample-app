require 'rails_helper'

RSpec.describe 'static_pages/contact', type: :view do
  before do
    render template: 'static_pages/contact', layout: 'layouts/application'
  end

  it 'is contact title' do
    expect(rendered).to have_title(full_title(t('static_pages.contact.title')))
  end
end
