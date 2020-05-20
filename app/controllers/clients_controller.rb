class ClientsController < ApplicationController
  before_action :require_admin

  def index
    @clients = Client.all
    if params[:segment].present?
      @clients = @clients.where(segment: params[:segment])
    end
    # les requêtes ci-dessus permettent de filtrer selon les valeurs cliquées dans les dropdown menus (cf. JS file dropdown.js)
    # POUR MEMOIRE : params[:xxx] correspond à la query dans l'URL, par exemple pour l'URL http://www.goutsdfruits.fr/products?&fruit=cerise, params[:fruit] = cerise
    # on peut cumuler des requetes Active Record (cf. plus haut) car elles ne sont pas appliquées tant qu'on ne fait pas un each ou un sort dessus (cf. ligne plus bas)

    @clients = @clients.sort_by do |client|
      client.last_name
    end

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

  def client_params
    params.require(:client).permit(:segment)
  end

end
