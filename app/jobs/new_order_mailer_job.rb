class NewOrderMailerJob
  include SuckerPunch::Job

  def perform(client)
    OrderMailer.new_order_email(client).deliver
  end
end
