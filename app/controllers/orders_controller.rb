class OrdersController < ApplicationController
  def prepare
    @order = Order.find(params[:id])
    if @order.status == "pending"
      @order.status = "prepared"
      @order.save!
      redirect_to dashboard_path
    else
      @order.status = "pending"
      @order.save!
      redirect_to dashboard_path
    end
  end

  def deliver
    @order = Order.find(params[:id])
    if @order.status == "prepared"
      @order.status = "delivered"
      @order.save!
      redirect_to dashboard_path
    else
      @order.status = "prepared"
      @order.save!
      redirect_to dashboard_path
    end
  end

  def pay
    @order = Order.find(params[:id])
    if @order.status == "delivered"
      @order.status = "paied"
      @order.save!
      redirect_to dashboard_path
    else
      @order.status = "delivered"
      @order.save!
      redirect_to dashboard_path
    end
  end

  def new
    @order = Order.new
    @order.order_lines.build
  end

  def create
    @order = Order.new(order_params)
    # binding.pry

    @order.order_lines.each do |order_line|
      order_line.total_price_cents = order_line.product.unit_price * order_line.quantity
      @order.total_price_cents += order_line.total_price_cents
    end

    if @order.save!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:client_id, order_lines_attributes: [:product_id, :quantity])
  end
end
