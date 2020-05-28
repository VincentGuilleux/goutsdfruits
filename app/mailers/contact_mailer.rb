class ContactMailer < ApplicationMailer
  # default from: 'notifications@example.com'

  def contact(message)
    @message = message
    # @email = email
    mail(to: 'vincentguilleux11@gmail.com', subject: 'Nouveau message depuis le formulaire de contact goutsdfruits.fr')
    # , from: email
  end
end
