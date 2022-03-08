# frozen_string_literal: true

class SessionsController < ApplicationController
  # GET /login
  def new; end

  # POST /login
  def create
    strong_params = session_params

    user = User.find_by_email_or_username(strong_params[:login])
    if user&.authenticate(strong_params[:password])
      reset_session

      # If user has selected remember me via checkbox on session login
      strong_params[:remember_me] == "1" ? remember(user) : forget(user)
      log_in user

      redirect_to user
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
end
