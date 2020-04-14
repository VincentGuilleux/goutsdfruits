class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :order_line_product_lots
  has_many :product_lots, through: :order_line_product_lots
end
