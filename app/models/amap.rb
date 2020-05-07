class Amap < ApplicationRecord
  has_many :clients
  validates :name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
end
