class ProductsController < ApplicationController
  before_action :require_admin, :except => [:index, :show]
  skip_before_action :authenticate_client!, :only => [:index, :show]

  # flash.now[:notice] = "Veuillez créer un compte pour pouvoir commander depuis cette page" if current_client.nil?

  def index
    @order = Order.new #Création de commande depuis l'index client donc il faut instancier un nouvel order
    @products = Product.includes(:product_lots, :photo_attachment) # initialement Product.all
    # @products = Product.includes(:product_lots, :photo_attachment).find([xxx,yyy]) utile pour test sur magasin
    # les requêtes ci-dessous permettent de filtrer selon les valeurs cliquées dans les dropdown menus (cf. JS file dropdown.js)
    # POUR MEMOIRE : params[:xxx] correspond à la query dans l'URL, par exemple pour l'URL http://www.goutsdfruits.fr/products?&fruit=cerise, params[:fruit] = cerise
    # on peut cumuler des requetes Active Record (cf. plus haut) car elles ne sont pas appliquées tant qu'on ne fait pas un each ou un sort dessus (cf. ligne plus bas)
    if params[:fruit].present?
      @products = @products.where(product_fruit: params[:fruit])
    end
    if params[:category].present?
      @products = @products.where(product_category: params[:category])
    end
    if params[:type].present?
      @products = @products.where(product_type: params[:type])
    end

    @products.each do |product|
      @order.order_lines.build product_id: product.id, quantity: 0
    end

     # Filtre sur prix magasin / non-magasin, par défaut en non-magasin
    @type_price = params[:price] || "non-magasin"

    # TRI D'AFFICHAGE DES PRODUITS

    # on n'affiche que les produits avec quantités > 0 (hormis pour profil admin)
    if current_client && current_client.segment == 'magasin'
      @products = @products.to_a.select { |product| product.total_remaining_quantity_shop > 0}
    end
    if current_client.nil? || current_client.role != "admin"
     @products = @products.to_a.select { |product| product.total_remaining_quantity > 0}
    end

    # En vision magasin, on n'affiche pas les produits non vendus aux magasins
    if (current_client && current_client.role == "admin" && @type_price == "magasin") || (current_client && current_client.segment == 'magasin')
      @products = @products.to_a.reject {|product| product.unit_price_cents_shop.nil?}
    end

    # Tri par quantités croissantes pour admin, par ordre alphabétique sinon
    if current_client.nil? || current_client.role != "admin"
      @products = @products.sort_by do |product|
        product.name
      end
    else
      @products = @products.sort_by do |product|
        product.total_remaining_quantity
      end
    end

  end

  def show
    @product = Product.find(params[:id])
    @product_lot = ProductLot.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    @product.unit_measure_quantity_shop = @product.unit_measure_quantity if @product.unit_measure_quantity_shop.nil?
    # pour les besoins de la méthode total_remaining_quantity_shop qui nécessite que le champ unit_measure_quantity_shop soit renseigné

    if @product.save
      redirect_to products_path
    else
      flash.now[:alert] = "Les champs en rouge doivent être saisis"
      render :new
      return
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :unit_price_cents, :unit_price_cents_shop, :unit_type, :unit_measure, :unit_measure_quantity, :unit_measure_quantity_shop, :product_fruit, :product_type, :product_category, :photo)
  end

end
