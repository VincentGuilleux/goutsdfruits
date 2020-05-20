class ClientsController < ApplicationController
  before_action :require_admin

  def index
    @clients = Client.all
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def require_admin
    unless current_client.role == "admin"
      flash[:error] = "Cette page n'est accessible qu'avec un profil administrateur"
      redirect_to root_path
    end
  end

end
