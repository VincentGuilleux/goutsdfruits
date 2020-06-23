# Base class for all mail classes like contact_mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'goutsdfruits@gmail.com'
  layout 'mailer'
end
