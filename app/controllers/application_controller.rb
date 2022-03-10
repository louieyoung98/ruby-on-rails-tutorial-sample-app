# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Katalyst::Tables::Backend
  include Pagy::Backend

  helper_method :log_in, :log_out, :current_user, :current_user?, :logged_in?

  # POST /session (create new session)
  # Log in to the given user object
  def log_in(user)
    return nil if user.blank?

    reset_session

    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  # DELETE /session (delete session)
  def log_out
    forget(current_user)
    reset_session
  end

  def forget(user)
    user.forget

    cookies.delete :user_id
    cookies.delete :remember_token
  end

  # Retrieves the currently 'logged in' user through two methods;
  #   1) If a session currently exists from a user logging in
  #   2) Fallback to cookies stored on browser to verify user authenticity
  #
  # Returns current user (object) or nil if no user can be found.
  def current_user
    @current_user ||= (find_user_from_session || find_user_from_cookie)
  end

  # Validates that the passed user object or user id is the current logged in user.
  # Example
  # `current_user?(user: User.new)`
  # `current_user?(user_id: params[:id])`
  def current_user?(**options)
    user = nil

    if options[:user_id]
      user = User.find_by(id: options[:user_id])
    elsif options[:user]
      user = options[:user]
    end

    user == current_user
  end

  def find_user_from_session
    return if (user_id = session[:user_id]).nil?

    user = User.find_by(id: user_id)
    @current_user = user && session[:session_token] == user.session_token ? user : nil
  end

  def find_user_from_cookie
    return if (user_id = cookies.encrypted[:user_id]).nil? || (remember_token = cookies.encrypted[:remember_token]).nil?

    user = User.find_by(id: user_id)
    @current_user = user&.authenticated?(remember_token) && (log_in user) ? user : nil
  end

  def logged_in?
    !current_user.nil?
  end

  # Remembers a user within a persistent state
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.encrypted[:remember_token] = user.remember_token
  end

  def redirect_back_or(forwarding_url, default)
    redirect_to(forwarding_url || default)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
