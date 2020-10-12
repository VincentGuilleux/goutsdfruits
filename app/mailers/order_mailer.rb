class OrderMailer < ApplicationMailer

  def new_order_email(client)
    mail(to: client.email, subject: 'Nouvelle commande GoutsdFruits')
  end

  def deleted_order_email(client)
    mail(to: client.email, subject: 'Commande GoutsdFruits supprimée')
  end

  def new_order_email_notification(client)
    mail(to: 'goutsdfruits@gmail.com', subject: "Nouvelle commande passée par #{client.first_name} #{client.last_name}")
  end

  def deleted_order_email_notification(client)
    mail(to: 'goutsdfruits@gmail.com', subject: "Commande supprimée par #{client.first_name} #{client.last_name}")
  end

end
