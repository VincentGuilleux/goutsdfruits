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

    @order.date = Date.today

    sum = 0

    @order.order_lines.each do |order_line|
      order_line.total_price_cents = order_line.product.unit_price_cents * order_line.quantity
      sum += order_line.total_price_cents
    end

    @order.total_price_cents = sum

    if @order.save!
      # generate_junction
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:client_id, order_lines_attributes: [:product_id, :quantity])
  end

  # def generate_junction
  #   @order.order_lines.each do |order_line|
  #     @order_line_product_lot = OrderLineProductLot.new
  #     @order_line_product_lot.quantity = order_line.quantity
  #     @order_line_product_lot.order_line_id = order_line.id

  #     if order_line.product.product_lots.first.remaining_quantity >= order_line.quantity
  #       @order_line_product_lot.product_lot_id = order_line.product.product_lots.first.id
  #       order_line.product_lots.first.remaining_quantity -= order_line.quantity
  #     else
  #       @order_line_product_lot.product_lot_id = order_line.product.product_lots.first.id
  #       @order_line_product_lot.quantity = order_line.product_lots.first.remaining_quantity
  #       @order_line_product_lot = OrderLineProductLot.new
        # end


  #     binding.pry
  #   end
  # end
end
