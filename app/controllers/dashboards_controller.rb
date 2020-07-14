class DashboardsController < ApplicationController
  before_action :require_admin

  def show
    @orders = Order.order(created_at: :desc).includes(:client, :order_lines, :products).where("status != ?", "paid")
    @top_products = Product.joins(:order_lines).select("products.*, SUM(order_lines.quantity) AS total_quantity").order(total_quantity: :desc).group("products.id").limit(3)
    @new_clients_current_month_count = Client.new_clients_current_month.count
    @orders_number_current_month = Order.orders_current_month.count
    @orders_total_current_month = Order.orders_current_month.sum(:total_price_cents) / 100
  end

end
