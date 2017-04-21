class Api::AuthorizationsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      render json: { authorization: @user.authorization_token }
    else
      render json: { message: error.to_s, status: :not_found }
    end
  end

  def destroy
    @current_user.logout
  end
end
