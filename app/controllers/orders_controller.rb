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
      @order.status = "deliver"
      @order.save!
      redirect_to dashboard_path
    else
      @order.status = "prepared"
      @order.save!
      redirect_to dashboard_path
    end
  end
end
