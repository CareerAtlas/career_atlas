class Api::UsersController < ApplicationController

  def create
    binding.pry
    @new_user = User.new(user_params)
    @new_user.secure_random
    if @new_user.save
      render json: {authorization: @new_user.authorization_token}
    else
      render json: { message: error.to_s, status: :unprocessable_entity }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
