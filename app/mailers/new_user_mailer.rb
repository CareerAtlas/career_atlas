class NewUserMailer < ApplicationMailer
  default from: "careeratlas1@gmail.com"

  def sign_up_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CareerAtlas #{@user.username}!")
  end
end
