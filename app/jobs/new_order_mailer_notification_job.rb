class NewOrderMailerNotificationJob
  include SuckerPunch::Job

  def perform(client)
    OrderMailer.new_order_email_notification(client).deliver
  end
end
