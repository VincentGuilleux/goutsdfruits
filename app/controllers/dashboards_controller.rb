class DashboardsController < ApplicationController
  def show
    @orders = Order.order(date: :desc).includes(:client, :order_lines, :products)
  end


end
