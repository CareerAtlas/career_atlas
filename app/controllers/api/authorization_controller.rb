class Api::AuthorizationController < ApplicationController

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
  end
end
