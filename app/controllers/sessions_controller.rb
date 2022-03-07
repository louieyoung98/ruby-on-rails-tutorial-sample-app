class SessionsController < ApplicationController
  # GET /login
  def new; end

  # POST /login
  def create
    strong_params = session_params

    user = User.find_by(email: strong_params[:email])
    if !!user&.authenticate(strong_params[:password])
      # TODO: Implement session login functionality
    else
      flash.now[:danger] = "Invalid Email/Username or Password"
      render "new"
    end
  end

  # DELETE /login
  def destroy; end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password,
    )
  end
end
