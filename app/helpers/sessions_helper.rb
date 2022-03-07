# frozen_string_literal: true

module SessionsHelper
  # Log in to the given user object
  def log_in(user)
    return nil if user.blank?

    reset_session
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def log_out
    @current_user = nil
    reset_session
  end

  def logged_in
    !current_user.nil?
  end
end
