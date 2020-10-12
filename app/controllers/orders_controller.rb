class OrdersController < ApplicationController

  def index
    if current_client.role == "admin"
      @orders = Order.order(created_at: :desc).includes(:client, :delivery_place, order_lines: :product)
      # respond_to do |format| # lignes pour export Excel via gem caxlsx
      #   format.xlsx {
      #     response.headers[
      #       'Content-Disposition'
      #     ] = "attachment; filename=commandes.xlsx"
      #   }
      #   format.html { render :index }
      # end
      # Supprimé car les filtres ne fonctionnent plus avec les lignes commmentées ci-dessus et a priori pas nécessaire pour générer le fichier Excel malgré la doc : https://medium.com/@JasonCodes/ruby-on-rails-exporting-data-to-excel-b3b204281085
    else
      @orders = current_client.orders.order(created_at: :desc).includes(:delivery_place, order_lines: :product) # même si pour l'instant en vue client on n'affiche pas la delivery place
    end

    if params[:segment_order].present?
      if "#{params[:segment_order]}" == "AMAP"
        @orders = @orders.select {|order| order.client.amap != "Non-membre"}
      else
        @orders = @orders.select {|order| order.client.segment == "#{params[:segment_order]}"}
      end
    end

    if params[:status].present?
      if "#{params[:status]}" == "A préparer"
        @orders = @orders.select {|order| order.status == 'pending'}
      elsif "#{params[:status]}" == "Préparées"
        @orders = @orders.select {|order| order.status == 'prepared'}
      elsif "#{params[:status]}" == "Livrées"
        @orders = @orders.select {|order| order.status == 'delivered'}
      elsif "#{params[:status]}" == "Payées"
        @orders = @orders.select {|order| order.status == 'paid'}
      end
    end

    if params[:delivery_place].present?
      @orders = @orders.select {|order| order.delivery_place.name == "#{params[:delivery_place]}"}
    end
  end

  # METHODES STATUTS COMMANDES

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

  # METHODES D'INSTANCIATION/CREATION/SUPPRESSION DE CMDS
  def new
    @order = Order.new
    @order.order_lines.build # crée un order_line à vide
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.today
    @order.order_lines = @order.order_lines.to_a.reject {|order_line| order_line.quantity.zero?} # supprime tous les order_lines à quantité nulle
    @order.total_price_cents = create_order_total_price

    if @order.total_price_cents == 0
      flash.keep[:alert] = "Vous n'avez sélectionné aucun produit - la commande ne peut pas être passée."
      redirect_to products_path
      return
    end

    if @order.client.nil? && @current_client.role == "admin"
      flash.keep[:alert] = "Vous n'avez sélectionné aucun client - la commande ne peut pas être enregistrée."
      redirect_to orders_path
      return
    end

    create_order_client
    create_order_payment_status # renvoit paid si méthode de paiement sélectionnée
    create_order_delivery_place

    if @order.save!
      generate_order_line_product_lots
      send_mail_new_order
      redirect_to orders_path
      flash[:notice] = "Votre commande a bien été enregistrée !"
    else
      render :new
    end
  end

  def destroy
    @order = Order.find(params[:id])
    unless @order.status == "pending"
      flash.keep[:alert] = "La commande a déjà été traitée, elle ne peut pas être supprimée."
      redirect_to orders_path
      return
    end
    regenerate_order_line_product_lots
    @order.destroy
    send_mail_deleted_order
    redirect_to orders_path
    flash[:notice] = "La commande a été supprimée."
  end

  private

  def order_params
    params.require(:order).permit(:client_id, :payment_method, :status, :pickup_date, :delivery_place_id, order_lines_attributes: [:product_id, :quantity])
  end

  def create_order_total_price
    sum = 0
    @order.order_lines.each do |order_line|
      if order_line.quantity <= order_line.product.total_remaining_quantity
        if current_client && current_client.segment == "magasin"
          order_line.total_price_cents = order_line.product.unit_price_cents_shop / order_line.product.ratio * order_line.quantity
        else
          order_line.total_price_cents = order_line.product.unit_price_cents * order_line.quantity
        end
        sum += order_line.total_price_cents
      else
        flash.now[:alert] = "Il n'y a pas assez de stock disponible pour ce produit - la commande ne peut pas être passée."
        render :new
        return
      end
    end
    return sum
  end
    # calcule order_price dans sum + check qu'il y a une quantité suff° pour chaque order line

  def create_order_client
  # Si pas de client sélectionné, on affecte au current_client (sinon on est dans le cas de l'admin qui sélectionne le client)
    if @order.client_id.nil?
        @order.client_id = current_client.id
    end
  end

  def create_order_payment_status
    unless @order.payment_method.nil?
      @order.status = "paid"
    end
  end

  def create_order_delivery_place
  # = magasin si client magasin / Ferme si client non-amap / AMAP si client AMAP
    if @order.delivery_place_id.nil? # nécessaire car si commande admin delivery_place déjà définie
      if @current_client.segment == "magasin"
        @order.delivery_place_id = DeliveryPlace.where("name = ?", "Magasin").first.id
      elsif @current_client.amap.nil? || @current_client.amap == "Non-membre"
        @order.delivery_place_id = DeliveryPlace.where("name = ?", "Ferme").first.id
      else
        @order.delivery_place_id = DeliveryPlace.where("name = ?", @current_client.amap).first.id
      end
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

  # Private method called when order deleted to regenerate product lots
  def regenerate_order_line_product_lots
    @order.order_lines.each do |order_line|
      selected_lots = order_line.product.product_lots.unexpired.order(:expiry_date)
      rebuild_quantity = order_line.quantity

      selected_lots.each do |selected_lot|
        break if rebuild_quantity == 0
        if selected_lot.quantity > selected_lot.remaining_quantity
          quantity = [rebuild_quantity, (selected_lot.quantity - selected_lot.remaining_quantity)].min
          selected_lot.remaining_quantity += quantity
          rebuild_quantity -= quantity
          selected_lot.save
        end
      end
    end
  end

  def send_mail_new_order
    NewOrderMailerJob.perform_async(current_client)
    NewOrderMailerNotificationJob.perform_async(current_client)
  end

  def send_mail_deleted_order
    OrderMailer.deleted_order_email(current_client).deliver_later
    OrderMailer.deleted_order_email_notification(current_client).deliver_later
  end

end
