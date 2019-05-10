# :nocov:
class ApplicationMailer < ActionMailer::Base
  default from: 'non.reply.bear.email@gmail.com'
  layout 'mailer'
end
# :nocov: