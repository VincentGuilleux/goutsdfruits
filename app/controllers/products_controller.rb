class ProductsController < ApplicationController
  before_action :require_admin, :except => [:index, :search]
  skip_before_action :authenticate_client!, :only => [:index, :search]

  def index
    products_initial_filter
    @order = Order.new # car création de commande depuis l'index client admin
    @product = Product.new
    @products.each do |product|
      @order.order_lines.build product_id: product.id, quantity: 0
    end

    # instanciation de type_price car utilisé dans la private method product_display_filtering
    # NB : même si par défaut type_price est setté sur "non-magasin", ne crée pas de problème de rendu de type de prix car la view partial _products fait appel à la product_helper method display_price qui affiche le prix adapté selon le client shop/non-shop
    @type_price = "non-magasin"
    product_display_filtering
    product_display_sorting

  end

  def search
    products_initial_filter
    @products = @products.search_by_name(params[:search][:name]) if params[:search].present? && params[:search][:name] != ""
    @products = @products.where(product_fruit: params[:search][:fruit]) if params[:search][:fruit].present? && params[:search][:fruit] != "Fruit"
    @products = @products.where(product_type: params[:search][:type]) if params[:search][:type].present? && params[:search][:type] != "Type"
    # instanciation de type_price car utilisé dans la private method product_display_filtering (on ne peut pas appeler params[:search][:type_price] depuis la méthode privée product_display_filtering)
    @type_price = params[:search][:type_price]
    product_display_filtering
    product_display_sorting

    # layout nil: renvoit juste le partial sans refaire appel à application.html.erb (afin d'éviter de générer une erreur JS car déjà preload)
    # locals: render_to_string nécessite une syntaxe spécifique 'locals'
    # NB: en cas de connexion magasin, même si par défaut via l'index type_price est setté sur "non-magasin", ne crée pas de problème de rendu de type de prix car la view partial _products fait appel à la product_helper method display_price qui affiche le prix adapté selon le client shop/non-shop
    render plain: render_to_string("products/_products", layout: nil, locals: { products: @products, type_price: params[:search][:type_price] })
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
    @product.unit_measure_quantity_shop = @product.unit_measure_quantity if @product.unit_measure_quantity_shop.nil? # pour les besoins de la méthode total_remaining_quantity_shop qui nécessite que le champ unit_measure_quantity_shop soit renseigné
    if @product.save
      redirect_to products_path
      flash[:notice] = "Le produit a été créé"
    else
      flash.now[:alert] = "Les champs en rouge doivent être saisis"
      render :new
      return
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
      flash[:notice] = "Le produit a été modifié"
    else
      redirect_to edit_product_path(@product.id)
      flash[:alert] = "Les champs en rouge doivent être saisis"
      return
    end
  end

  def destroy
    @product = Product.find(params[:id])
    unless @product.orders == []
      redirect_to product_path(@product)
      flash[:alert] = "Le produit ne peut pas être supprimé car des commandes ont été passées sur ce produit."
      return
    end
    unless @product.product_lots == []
      redirect_to product_path(@product)
      flash[:alert] = "Le produit ne peut pas être supprimé car des lots ont été générés"
      return
    end
    @product.destroy
    redirect_to products_path
    flash[:notice] = "Le produit a été supprimé"
  end

  private

  def products_initial_filter
    @products = Product.includes(photo_attachment: :blob)
  end

  def product_params
    params.require(:product).permit(:name, :description, :unit_price_cents, :unit_price_cents_shop, :unit_type, :unit_measure, :unit_measure_quantity, :unit_measure_quantity_shop, :product_fruit, :product_type, :product_category, :photo)
  end

  def product_display_filtering
    # on sélectionne slt les produits à quantité positive (pour les non-admins en différenciant shop/non-shop)
    if helpers.client_not_logged? || helpers.client_non_admin?
     @products = @products.to_a.select { |product| product.total_remaining_quantity > 0}
    end
    if helpers.client_shop?
      @products = @products.to_a.select { |product| product.total_remaining_quantity_shop > 0}
    end

    # On exclut les produits non vendus aux magasins (pour admin vue magasin et clients shop)
    # NB : non géré pour les clients shop par la cond° plus haut car les produits non-shop ont une total_remaining_quantity_shop égale à la total_remanining_quantity donc qui peut être positive
    if (helpers.client_admin? && @type_price == "magasin") || helpers.client_shop?
      @products = @products.to_a.reject {|product| product.unit_price_cents_shop.nil?}
    end
  end

  def product_display_sorting
    # message d'erreur si pas de produits
    @products == [] ? @message = 'Aucun produit ne correspond à votre sélection' : @message = ''
      # binding.pry
      # flash.now[:notice] = "Aucun produit ne correspond à votre sélection"

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

end
