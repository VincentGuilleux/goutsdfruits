class Order < ApplicationRecord
  belongs_to :client
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines

  accepts_nested_attributes_for :order_lines
end
