class ContactMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def contact(message)
    @message = message
    mail(to: 'vincentguilleux11@gmail.com', subject: 'Formulaire contact GoutsdsFruits')
  end
end
