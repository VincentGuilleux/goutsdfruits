class DeliveryPlace < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :post_code, presence: true
  validates :timeslot, presence: true

  def self.names
    DeliveryPlace.all.map(&:name).uniq.sort_by { |word| word.downcase }
  end

  # METHODE DEFINISSANT LE FILTRE LIEU DE LIVRAISON DE L'INDEX CLIENT
  # la méthode ci-dessous répond à une logique d'affichage uniquement donc pourrait être mises dans un helper plutôt
  def self.names_to_display
    DeliveryPlace.names.unshift('Lieu de livraison')
  end
end
