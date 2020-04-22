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
      @order.status = "paid"
      @order.save!
      redirect_to dashboard_path
    else
      @order.status = "delivered"
      @order.save!
      redirect_to dashboard_path
    end
  end

  def index
    @orders = Order.all
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
      if order_line.quantity > order_line.product.total_remaining_quantity
        flash[:alert] = "Il n'y a pas assez de stock"
      end

      order_line.total_price_cents = order_line.product.unit_price_cents * order_line.quantity
      sum += order_line.total_price_cents
    end

    @order.total_price_cents = sum

    if @order.save!
      generate_order_line_product_lots
      redirect_to orders_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:client_id, :payment_method, order_lines_attributes: [:product_id, :quantity])
  end

  def generate_order_line_product_lots
    @order.order_lines.each do |order_line|
      selected_lots = order_line.product.product_lots.where("expiry_date > ? AND remaining_quantity > 0", Date.today).order(:expiry_date)
      necessary_quantity = order_line.quantity

      selected_lots.each do |selected_lot|
        break if necessary_quantity == 0

        quantity = [necessary_quantity, selected_lot.remaining_quantity].min
        order_line_product_lot = OrderLineProductLot.new
        order_line_product_lot.order_line_id = order_line.id
        order_line_product_lot.product_lot = selected_lot
        order_line_product_lot.quantity = quantity
        order_line_product_lot.save

        selected_lot.remaining_quantity -= quantity
        selected_lot.save

        necessary_quantity -= quantity
      end
    end
  end
end
