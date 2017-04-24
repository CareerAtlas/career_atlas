class Api::UsersController < ApplicationController

  def create
    @new_user = User.new(user_params)
    @new_user.secure_random
    if @new_user.save
      render json: {authorization: @new_user.authorization_token}
    else
      render json: { message: @user.errors.to_s, status: :unprocessable_entity }
    end
  end

  def destroy
    @user = User.find_by(email: params[:email])
    if @user && @user.authorization_token == params[:authorization]
      @user.destroy
      render json: { message: "Account Deleted", status: :ok}
    else
      render json: {message: @user.errors.to_s, status: :unauthorized}
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
