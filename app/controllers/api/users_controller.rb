class Api::UsersController < ApplicationController
before_action :authorize!, only: [:destroy]

  def create
    @new_user = User.new(user_params)
    @new_user.secure_random
    if @new_user.save
      render json: {authorization: @new_user.authorization_token}
      NewUserMailer.sign_up_email(@new_user).deliver_now
    else
      render json: { message: "Please enter correct information", status: :unprocessable_entity }
    end
  end

  def destroy
    if current_user.destroy
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
