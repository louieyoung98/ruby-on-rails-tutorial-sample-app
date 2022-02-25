require 'rails_helper'

RSpec.describe 'static_pages/help', type: :view do
  before do
    render template: 'static_pages/help', layout: 'layouts/application'
  end

  it 'is help title' do
    expect(rendered).to have_title(full_title(t('static_pages.help.title')))
  end
end
