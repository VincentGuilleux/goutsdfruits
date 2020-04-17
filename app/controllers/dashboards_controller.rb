class DashboardsController < ApplicationController
  def show
    @orders = Order.includes(:client, :order_lines)
  end


end
