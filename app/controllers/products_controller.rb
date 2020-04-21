class ProductsController < ApplicationController

  def index
      @products = Product.all
    if params[:fruit].present?
      @products = @products.where(product_fruit: params[:fruit])
    end
    if params[:category].present?
      @products = @products.where(product_category: params[:category])
    end
    if params[:type].present?
      @products = @products.where(product_type: params[:type])
    end
      # on peut cumuler des requetes Active Record (cf. plus haut) car elles ne sont pas appliquées tant qu'on ne fait pas un each ou un sort dessus (cf. ligne plus bas)
      @products = @products.sort_by do |product|
        product.total_remaining_quantity
      end

  end

  def show
    @product = Product.find(params[:id])
    @product_lot = ProductLot.new
  end

end
