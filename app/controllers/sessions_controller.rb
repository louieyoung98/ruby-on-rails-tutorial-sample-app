# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in_user, only: :new

  # GET /login
  def new; end

  # POST /login
  def create
    @user = User.find_by_email_or_username(session_params[:login])
    if valid_login?
      log_in_and_redirect
    else
      if @user&.activated?
        flash.now[:warning] = t("session.create.flash.warning")
      elsif @user && !@user.activated?
        flash.now[:info] = t("session.create.flash.info").gsub! "{user.email}", @user.email
      else
        flash.now[:danger] = t("session.create.flash.danger")
      end

      render :new
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

  def valid_login?
    @user&.authenticate(session_params[:password]) && @user&.activated?
  end

  def log_in_and_redirect
    forwarding_url = session[:forwarding_url]
    reset_session

    # If user has selected remember me via checkbox on session login
    session_params[:remember_me] == "1" ? remember(@user) : forget(@user)
    log_in @user

    redirect_back_or forwarding_url, @user
  end
end
