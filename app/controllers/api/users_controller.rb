class Api::UsersController < ApplicationController

  def create
    @new_user = User.new(user_params)
    @new_user.secure_random
    if @new_user.save
      render json: {authorization: @new_user.authorization_token}
    else
      render json: { message: "Please enter correct information", status: :unprocessable_entity }
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user && @user.authorization_token == params[:Authorization]
      @user.destroy
      render json: { message: "Account Deleted", status: :ok}
    else
      render json: {message: "Please log in to delete an account", status: :unauthorized}
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
