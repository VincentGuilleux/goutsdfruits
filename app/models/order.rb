class Order < ApplicationRecord
  belongs_to :client
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines
  validates :total_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  accepts_nested_attributes_for :order_lines
end
