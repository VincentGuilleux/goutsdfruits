class Product < ApplicationRecord
  has_many :product_lots
  has_many :order_lines
  has_many :orders, through: :order_lines #allows to find all orders for a given product
  has_one_attached :photo

  def total_remaining_quantity
    total_remaining_quantity = 0
    product_lots.each do |product_lot|
      total_remaining_quantity += product_lot.remaining_quantity
    end
    return total_remaining_quantity
  end

end
