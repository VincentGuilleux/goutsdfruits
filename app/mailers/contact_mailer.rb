class ContactMailer < ApplicationMailer

  def contact(message, email)
    @message = message
    @email = email
    mail(to: 'goutsdfruits@gmail.com', subject: 'Nouveau message depuis le formulaire de contact goutsdfruits.fr')
  end
end
