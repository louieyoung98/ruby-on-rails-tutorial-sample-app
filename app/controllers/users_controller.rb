# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :administrator_user, only: :destroy

  def index
    @users = User.activated
    @sort, @users = table_sort @users # Default sorting, e.g., order_by_#{field_name} (Default scopes)
    @pagy, @users = pagy @users, page: params[:page], items: 10, link_extra: 'class="pagy-nav-active"' # then paginate
  end

  # POST /users
  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      @user.send_account_activation_email
      reset_session

      flash[:info] = t("users.create.flash.info").gsub! "{user.email}", @user.email

      redirect_to login_url
    else
      render "new"
    end
  end

  # DELETE /users/1
  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = t("users.destroy.flash.success")
    else
      flash[:danger] = t("users.destroy.flash.danger")
    end

    redirect_to users_url
  end

  # PATCH /users/1
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
    redirect_to users_path and nil unless @user.activated?
  end

  # GET /new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to users_path and nil unless @user.activated?
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
    redirect_to(root_url) unless current_user?(user_id: params[:id]) || current_user.administrator
  end

  def administrator_user
    redirect_to root_url unless current_user.administrator?
  end
end
