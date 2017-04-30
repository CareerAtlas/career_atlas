class NewUserMailer < ApplicationMailer

  def sing_up_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CareerAtlas #{@user.username}!")
  end
end
