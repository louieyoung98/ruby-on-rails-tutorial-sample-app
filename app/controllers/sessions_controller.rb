# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in_user, only: :new

  # GET /login
  def new; end

  # POST /login
  def create
    strong_params = session_params

    user = User.find_by_email_or_username(strong_params[:login])
    if user&.authenticate(strong_params[:password])
      forwarding_url = session[:forwarding_url]
      reset_session

      # If user has selected remember me via checkbox on session login
      strong_params[:remember_me] == "1" ? remember(user) : forget(user)
      log_in user

      redirect_back_or forwarding_url, user
    else
      flash.now[:danger] = "Invalid Email/Username or Password"

      render "new"
    end
  end

  # DELETE /login
  def destroy
    log_out if logged_in?

    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(
      :login,
      :password,
      :remember_me,
    )
  end

  def logged_in_user
    redirect_to root_url if logged_in?
  end
end
