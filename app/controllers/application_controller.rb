class ApplicationController < ActionController::Base
  before_action :authenticate_client!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def require_admin
    unless current_client.role == "admin"
      flash[:alert] = "Cette page n'est accessible qu'avec un profil administrateur"
      redirect_to root_path
    end
  end

end


