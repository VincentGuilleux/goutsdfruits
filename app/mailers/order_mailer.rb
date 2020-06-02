class OrderMailer < ApplicationMailer

 def new_order_email(client)
    mail(to: client.email, subject: 'Commande GoutsdFruits')
  end

end
