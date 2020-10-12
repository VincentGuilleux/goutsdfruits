class DeletedOrderMailerJob
  include SuckerPunch::Job

  def perform(client)
    OrderMailer.deleted_order_email(client).deliver
  end
end
