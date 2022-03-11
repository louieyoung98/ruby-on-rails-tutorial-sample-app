# frozen_string_literal: true

module ViewHelper
  def set_current_user(user = FactoryBot.create(:user))
    view.class_eval do
      define_method :logged_in? do
        user.present?
      end

      define_method :current_user do
        user
      end
    end
  end
end
