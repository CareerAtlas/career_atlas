class Api::AuthorizationController < ApplicationController
  before_action :authorize!, only: [:destroy]

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      render json: { authorization: @user.authorization_token }
    else
      render json: { message: "Email or Password in not correct", status: :not_found }
    end
  end

  def destroy
    current_user.logout
    render json: {message: "You are now logged out"}
  end
end
