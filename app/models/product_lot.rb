class ProductLot < ApplicationRecord

  belongs_to :product
  has_many :order_line_product_lots
  has_many :order_lines, through: :order_line_product_lots
  validates :lot_number, presence: true
  validates :production_date, presence: true
  validates :expiry_date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }


# Méthode notification dashboard
  def self.oldest_stock
    expiry_date_trigger = Date.today + 10 # Trigger fixe pour l'instant à J+10
    old_product_lots = ProductLot.where("expiry_date < ? AND remaining_quantity > 0", expiry_date_trigger).where("expiry_date > ?", Date.today).order(:expiry_date) # renvoit un array des product_lots avec date d'expiration comprise entre J et J+10 trié par date d'expiration (et dont quantité restante > 0)
    oldest_product_lot = old_product_lots.first # Pour l'instant ne renvoit qu'un item pour qu'on n'ait une seule notif pour stock ancien
  end

end
