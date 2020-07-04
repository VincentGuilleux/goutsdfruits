class OrderMailer < ApplicationMailer

  def new_order_email(client)
    mail(to: client.email, subject: 'Commande GoutsdFruits')
  end

  def new_order_email_notification(client)
    mail(to: 'goutsdfruits@gmail.com', subject: "Nouvelle commande passée par #{client.first_name} #{client.last_name}")
  end

end
