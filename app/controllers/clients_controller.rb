class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
