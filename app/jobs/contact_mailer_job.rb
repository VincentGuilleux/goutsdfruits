class ContactMailerJob
  include SuckerPunch::Job

  def perform(message, email)
    ContactMailer.contact(message, email).deliver
  end
end
