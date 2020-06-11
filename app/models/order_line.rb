class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :order_line_product_lots, dependent: :destroy
  has_many :product_lots, through: :order_line_product_lots
  validates :total_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
