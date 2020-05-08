class Client < ApplicationRecord
  has_many :orders
  # belongs_to :AMAP
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :segment, presence: true, inclusion: { in: %w(particulier magasin marché CE drive),
    message: "%{value} n'est pas un type de client valable" }

  def full_name
    "#{first_name} #{last_name}"
  end
end
