class UsersController < ApplicationController

  # POST /users
  def create
    @user = User.new(user_params)  # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render "new"
    end
  end

  def update; end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /new
  def new
    @user = User.new
  end


  # Start private functions
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
