# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      reset_session

      user.activate
      log_in user

      flash[:success] = t("account_activation.edit.flash.success")

      redirect_to user
    else
      flash[:danger] = t("account_activation.edit.flash.danger")

      redirect_to login_url
    end
  end
end
