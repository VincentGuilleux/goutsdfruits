class OrdersController < ApplicationController

  def index
    if current_client.role == "admin"
      @orders = Order.order(created_at: :desc).includes(:client, :order_lines, :products)
    else
      @orders = current_client.orders.order(created_at: :desc).includes(:client, :order_lines, :products)
    end
  end

  def prepare
    @order = Order.find(params[:id])
    if @order.status == "pending"
      @order.status = "prepared"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
    else
      @order.status = "pending"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
    end
  end

  def deliver
    @order = Order.find(params[:id])
    if @order.status != "delivered"
      @order.status = "delivered"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
    else
      @order.status = "prepared"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
    end
  end

  def pay
    @order = Order.find(params[:id])
    if @order.status != "paid"
      @order.status = "paid"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
    else
      @order.status = "delivered"
      @order.save!
      redirect_back(fallback_location: dashboard_path)
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
      if order_line.quantity <= order_line.product.total_remaining_quantity
        order_line.total_price_cents = order_line.product.unit_price_cents * order_line.quantity
        sum += order_line.total_price_cents
      else
        flash.now[:alert] = "Il n'y a pas assez de stock disponible pour ce produit - La commande ne peut pas être passée"
        render :new
        return
      end
    end

    @order.total_price_cents = sum

    create_order_payment_status # renvoit paid si méthode de paiement sélectionnée

    # Si pas de delivery place sélectionnée, on affecte par défaut à la ferme
    if @order.delivery_place_id.nil?
      @order.delivery_place = DeliveryPlace.first
    end

    # Si pas de client sélectionné, on affecte au current_client (sinon on est dans le cas de l'admin qui sélectionne le client)
    if @order.client_id.nil?
        @order.client_id = current_client.id
    end

    # Si commande passée, on appelle la méthode generate_order_line_product_lots qui vient décrémenter les stocks en fonction de la quantité commandée pour chaque order line
    if @order.save!
      generate_order_line_product_lots
      send_mail_new_order
      redirect_to orders_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:client_id, :payment_method, :status, :pickup_date, order_lines_attributes: [:product_id, :quantity])
  end

  def create_order_payment_status
    if @order.payment_method != ""
      @order.status = "paid"
    end
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

  def send_mail_new_order
    OrderMailer.new_order_email(current_client).deliver
  end

end
