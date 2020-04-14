class ProductLot < ApplicationRecord
  belongs_to :product
  has_many :order_line_product_lots
  has_many :order_lines, through: :order_line_product_lots
end
