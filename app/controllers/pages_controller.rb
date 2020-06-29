class PagesController < ApplicationController
  skip_before_action :authenticate_client!

  def home
  end

  def show
    render template: "pages/#{params[:page]}"
  end

  def send_contact
     ContactMailer.contact(params[:message], params[:email]).deliver
     flash[:notice] = "Votre message a bien été envoyé !"
     redirect_back(fallback_location: root_path) # les messages flash Rails ne s'affichent qu'après rechargement de la page·
  end

end
