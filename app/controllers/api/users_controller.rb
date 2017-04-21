class Api::UsersController < ApplicationController

  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: {}
    else
      render json: {}
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
