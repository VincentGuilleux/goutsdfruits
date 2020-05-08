class ClientsController < ApplicationController
  def index
    @clients = Client.includes(:amap)
  end
end
