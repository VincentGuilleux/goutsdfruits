class DashboardsController < ApplicationController
  def show
    @orders = Order.includes(:client, :order_lines)
  end

  def products_total_value
    # Product.select(:unit_price_cents)
    # ProductLot.sum(:remaining_quantity)
  end

  def orders_number_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).count
  end

  def orders_total_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).sum(:total_price_cents)/100
  end

  def new_clients_current_month
    Client.where('extract(year from created_at) = ?', year_now).where('extract(month from created_at) = ?', month_now).count
  end

  helper_method :products_total_value, :new_clients_current_month, :orders_number_current_month, :orders_total_current_month

  private

  def month_now
    Date.today.month
  end

  def year_now
    Date.today.year
  end

end
