class ClientsController < ApplicationController
  before_action :require_admin, :except => [:edit, :update]

  def index
    @clients = Client.all.ordered_by_last_name
    if params[:segment].present?
      @clients = @clients.where(segment: params[:segment])
    end
    if params[:amap].present?
      @clients = @clients.where(amap: params[:amap])
    end
  end

  def destroy
    @client = Client.find(params[:id])
    unless @client.orders.nil?
      flash.keep[:alert] = "Le client sélectionné a déjà passé des commandes, il ne peut pas être supprimé."
      redirect_to clients_path
      return
    end
    @client.destroy
    flash[:notice] = "Le client a été supprimé."
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :phone, :address, :post_code, :city, :amap, :segment)
  end

end
