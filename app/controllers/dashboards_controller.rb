class DashboardsController < ApplicationController

  helper_method :products_total_value, :new_clients_current_month, :orders_number_current_month, :orders_total_current_month, :lowest_stock, :oldest_stock
  # Pas très propre on ne devrait pas définir les méthodes ci-dessous en helper mais les méthodes ci-dessous devraient être reclassées dans les modèles des classes correspondantes et pour celles qui sont des requêtes SQL utiliser scope:
    # Par exemple pour orders_number_current_month à reclasser dans Order model
      #   scope :for_current_month, -> do
      #     where('extract(year from date) = ? AND extract(month from date) = ?', Date.today.year, Date.today.month)
      #   end
      # end
     # On pourrait ensuite rajouter dans la show du controlleur dashboard @current_month_orders = Order.for_current_month.count et l'appeler de cette façon
     # l'intérêt d'un scope par rapport à une méthode de Classe c'est que cela fonctionne un peu comme une méthode ActiveRecord on peut donc y chaîner d'autres requêtes SQL ou méthodes.

  def show
    @orders = Order.order(created_at: :desc).includes(:client, :order_lines, :products).where("status != ?", "delivered")
    @top_products = Product.joins(:order_lines).select("products.*, SUM(order_lines.quantity) AS total_quantity").order(total_quantity: :desc).group("products.id").limit(3)
  end

  def products_total_value
    @products = Product.all
    products_total_value = 0
    @products.each do |product|
      products_total_value += product.unit_price_cents * product.total_remaining_quantity
    end
    return products_total_value/100
  end

  # Methods used to calculated monthly_data stats

  def orders_number_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).count
  end

  def orders_total_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).sum(:total_price_cents)/100
  end

  def new_clients_current_month
    Client.where('extract(year from created_at) = ?', year_now).where('extract(month from created_at) = ?', month_now).count
  end

  # Methods used for notifications

  def lowest_stock # A refactoriser via méthode SQL, on peut faire beaucoup plus court
  # Pour chaque produit récupérer la remaining quantity
  # Vérifier si cette valeur est inférieure à un critère donné
  # Renvoyer la liste de tous les produits concernés
    @products = Product.all
    @products = @products.sort_by do |product|
        product.total_remaining_quantity
      end
    low_stock_trigger = 3 # Plancher de quantité qui trigger l'alimentation de la liste des low_stocks
    low_stock_list = Array.new
    @products.each do |product|
       if product.total_remaining_quantity < low_stock_trigger
       low_stock_list << product
       end
    end
    return low_stock_list.first # Pour l'instant on ne renvoit qu'un item pour qu'on ait une seule notif pour stock bas
  end

  def oldest_stock
    expiry_date_trigger = Date.today + 10 # Trigger fixe pour l'instant à J+10
    # old_stock_list = Array.new
    old_product_lots = ProductLot.where("expiry_date < ? AND remaining_quantity > 0", expiry_date_trigger).order(:expiry_date) # renvoit un array des product_lots répondant aux cond° ci-dessus et trié par date d'expiration
    # old_product_lots.each do |old_product_lot|
    #   old_product_lot = Product.find(old_product_lot.product_id)
    #   old_product = Product.find(old_product_lot.product_id)
    #   old_stock_list << old_product # crée un array de tous les produits satisfaisant à la cond° d'ancienneté
    # end
    oldest_product = old_product_lots.first # Pour l'instant ne renvoit qu'un item pour qu'on ait une seule notif pour stock ancien
  end


  private

  def month_now
    Date.today.month
  end

  def year_now
    Date.today.year
  end

end
