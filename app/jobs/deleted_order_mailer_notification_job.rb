class DeletedOrderMailerNotificationJob
  include SuckerPunch::Job

  def perform(client)
    OrderMailer.deleted_order_email_notification(client).deliver
  end
end
