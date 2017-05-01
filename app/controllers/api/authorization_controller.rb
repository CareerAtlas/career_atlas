class Api::AuthorizationController < ApplicationController
  before_action :authorize!, only: [:destroy]

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      render json: { authorization: @user.authorization_token }
    else
      render json: { message: "Email or Password in not correct", status: :bad_request }, status: 400
    end
  end

  def destroy
    current_user.logout
    render json: {message: "You are now logged out"}
  end

  private
  def authorize!
    unless current_user
      render json: {message: "Please log in first"}
    end
  end
end
