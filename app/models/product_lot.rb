class ProductLot < ApplicationRecord
  belongs_to :product
  has_many :order_line_product_lots
  has_many :order_lines, through: :order_line_product_lots
  validates :lot_number, presence: true
  validates :production_date, presence: true
  validates :expiry_date, presence: true
  validates :quantity, presence: true
end
