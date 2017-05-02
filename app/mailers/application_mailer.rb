class ApplicationMailer < ActionMailer::Base
  default from: ENV["CAREERATLAS_EMAIL"]
  layout 'mailer'
end
