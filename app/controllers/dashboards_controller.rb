class DashboardsController < ApplicationController
  def show
    @orders = Order.order(date: :asc).includes(:client, :order_lines, :products)

  end


end
