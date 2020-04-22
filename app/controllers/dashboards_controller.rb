class DashboardsController < ApplicationController
  def show
    @orders = Order.order(created_at: :desc).includes(:client, :order_lines, :products)
  end

  def products_total_value
    # for each product, calculate its remaining_quantity * price
    # ProductLot.select("SUM(ProductLot.remaining_quantity")
    # Product.joins(:products_lots).remaining_quantity.count
    # Product.select(:unit_price_cents)
    # ProductLot.sum(:remaining_quantity)
    @products = Product.all
    products_total_value = 0
    @products.each do |product|
      products_total_value += product.unit_price_cents * product.total_remaining_quantity
    end
    return products_total_value/100
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
