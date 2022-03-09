# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @user = User.new
    render "new"
  end

  # POST /users
  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
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

  # End private functions
end
