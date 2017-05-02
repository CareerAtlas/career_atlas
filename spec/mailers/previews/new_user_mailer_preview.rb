# Preview all emails at http://localhost:3000/rails/mailers/new_user_mailer
class NewUserMailerPreview < ActionMailer::Preview
  def sign_up_email
    NewUserMailer.sign_up_email(User.last)
  end
end
