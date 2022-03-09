# frozen_string_literal: true
module ApplicationHelper
  include Katalyst::Tables::Frontend
  include Pagy::Frontend

  # Returns the value inserted into 'title' element upon render of the page
  #
  # Utilising string concatenation over string interpolation to
  # prevent potential hidden escape characters in page_title
  #
  # @param page_title [String]
  # @return [String]
  def full_title(page_title = '')
    full_title = I18n.t('application.title')
    page_title.empty? == false ? page_title + ' | ' + full_title : full_title
  end
end
