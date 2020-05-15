class DeliveryPlace < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :post_code, presence: true
  validates :timeslot, presence: true
end
