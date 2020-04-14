class OrderLineProductLot < ApplicationRecord
  belongs_to :product_lot
  belongs_to :order_line
end
