# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def index
    @user = User.new
    render "new"
  end

  # POST /users
  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      reset_session
      log_in @user
      flash[:success] = t("users.flash.success")

      redirect_to @user
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user&.update(user_params)
      flash[:success] = t("users.edit.flash.success")
      redirect_to @user
    else
      render "edit"
    end
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :phone_number,
      :password,
      :password_confirmation,
    )
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user?(user_id: params[:id])
  end
end
