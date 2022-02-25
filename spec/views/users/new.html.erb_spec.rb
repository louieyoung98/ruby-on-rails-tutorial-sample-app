require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  before do
    render template: 'users/new', layout: 'layouts/application'
  end

  it 'is new title' do
    expect(rendered).to have_title(full_title('Signup'))
  end
end
