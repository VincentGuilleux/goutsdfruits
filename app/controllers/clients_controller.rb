class ClientsController < ApplicationController
  before_action :require_admin, :except => [:edit, :update]

  def index
    @clients = Client.all
    if params[:segment].present?
      @clients = @clients.where(segment: params[:segment])
    end
    if params[:amap].present?
      @clients = @clients.where(amap: params[:amap])
    end

    @clients = @clients.sort_by do |client|
      client.last_name
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :phone, :address, :post_code, :city, :amap, :segment)
  end

end
