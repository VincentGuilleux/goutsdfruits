class ProductLotsController < ApplicationController
  def create
    @product_lot = ProductLot.new(product_lot_params)
    @product = Product.find(params[:product_id])

    @product_lot.product = @product
    @product_lot.remaining_quantity = @product_lot.quantity

    @product_lot.save
    redirect_to product_path(@product)

  end

  private

  def product_lot_params
    params.require(:product_lot).permit(:lot_number,:production_date,:expiry_date, :quantity)
  end

end
