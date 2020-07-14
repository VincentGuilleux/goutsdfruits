class Order < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_place
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines
  validates :total_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  accepts_nested_attributes_for :order_lines

  # utilisation de scopes plutôt que de méthodes de classe pour les requêtes SQL car fonctionne un peu comme une méthode ActiveRecord on peut donc y chaîner d'autres requêtes SQL ou méthodes => https://guides.rubyonrails.org/active_record_querying.html#scopes
  scope :orders_current_month, -> {where('extract(year from date) = ?', Date.today.year).where('extract(month from date) = ?', Date.today.month)}

  def self.total_value_per_month(year)
    orders_total_per_month = []
    for i in 1..Date.today.month
      orders_total_per_month << (Order.where('extract(year from date) = ?', year).where('extract(month from date) = ?', i).sum(:total_price_cents) / 100)
    end
    orders_total_per_month
  end

  scope :orders_total_previous_month, ->(x) {where('extract(year from date) = ?', Date.today.year).where('extract(month from date) = ?', (Time.now - x.month).month).sum(:total_price_cents) / 100}

end
