# Base class for all mail classes like contact_mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'vincent.guilleux11@gmail.com'
  layout 'mailer'
end
