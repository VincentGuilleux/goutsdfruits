class ProductsController < ApplicationController

  def index
      @products = Product.includes(:product_lots, :photo_attachment) # initialement Product.all
    if params[:fruit].present?
      @products = @products.where(product_fruit: params[:fruit])
    end
    if params[:category].present?
      @products = @products.where(product_category: params[:category])
    end
    if params[:type].present?
      @products = @products.where(product_type: params[:type])
    end
      # les requêtes ci-dessus permettent de filtrer selon les valeurs cliquées dans les dropdown menus (cf. JS file dropdown.js)
      # POUR MEMOIRE : params[:xxx] correspond à la query dans l'URL, par exemple pour l'URL http://www.goutsdfruits.fr/products?&fruit=cerise, params[:fruit] = cerise
      # on peut cumuler des requetes Active Record (cf. plus haut) car elles ne sont pas appliquées tant qu'on ne fait pas un each ou un sort dessus (cf. ligne plus bas)
      @products = @products.sort_by do |product|
        product.total_remaining_quantity
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
    if @product.save!
      redirect_to products_path
    else
      # flash[:alert] = "Tous les champs doivent être saisis"
      render :new
      # return
    end
  end

     private

  def product_params
    params.require(:product).permit(:name, :description, :unit_price_cents, :unit_type, :product_fruit, :product_type, :product_category, :photo)
  end

end
