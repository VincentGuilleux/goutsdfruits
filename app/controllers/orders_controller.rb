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
end
