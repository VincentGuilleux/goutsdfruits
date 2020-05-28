class ApplicationController < ActionController::Base
  before_action :authenticate_client!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone, :address, :post_code, :city, :segment, :amap])
  end

  private

  def require_admin
    unless current_client.role == "admin"
      flash[:alert] = "Cette page n'est accessible qu'avec un profil administrateur"
      redirect_to root_path
    end
  end



end


