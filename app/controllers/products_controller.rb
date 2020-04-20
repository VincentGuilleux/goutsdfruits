class ProductsController < ApplicationController

  def index
    @products = Product.all.sort_by do |product|
      product.total_remaining_quantity
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_lot = ProductLot.new
  end

end
