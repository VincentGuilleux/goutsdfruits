class DashboardsController < ApplicationController
  before_action :require_admin

  helper_method :new_clients_current_month, :orders_number_current_month, :orders_total_previous_month, :orders_total_current_month
  # Pas très propre on ne devrait pas définir les méthodes ci-dessous en helper mais les méthodes ci-dessous devraient être reclassées dans les modèles des classes correspondantes et pour celles qui sont des requêtes SQL utiliser scope:
    # Par exemple pour orders_number_current_month à reclasser dans Order model
      #   scope :for_current_month, -> do
      #     where('extract(year from date) = ? AND extract(month from date) = ?', Date.today.year, Date.today.month)
      #   end
      # end
     # On pourrait ensuite rajouter dans la show du controlleur dashboard @current_month_orders = Order.for_current_month.count et l'appeler de cette façon
     # l'intérêt d'un scope par rapport à une méthode de Classe c'est que cela fonctionne un peu comme une méthode ActiveRecord on peut donc y chaîner d'autres requêtes SQL ou méthodes.

  def show
    @orders = Order.order(created_at: :desc).includes(:client, :order_lines, :products).where("status != ?", "paid")
    @top_products = Product.joins(:order_lines).select("products.*, SUM(order_lines.quantity) AS total_quantity").order(total_quantity: :desc).group("products.id").limit(3)
    @current_month_new_clients_count = Client.new_clients_current_month.count
  end

  # Methods used to calculated monthly_data stats
  def orders_number_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).count
  end

  def orders_total_previous_month(x)
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', previous_month(x)).sum(:total_price_cents) / 100
  end

  def orders_total_current_month
    Order.where('extract(year from date) = ?', year_now).where('extract(month from date) = ?', month_now).sum(:total_price_cents) / 100
  end

  private

  def month_now
    Date.today.month
  end

  def previous_month(x)
    (Time.now - x.month).month
  end

  def year_now
    Date.today.year
  end

end
