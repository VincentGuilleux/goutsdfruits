class Product < ApplicationRecord
  has_many :product_lots
  has_many :order_lines
  has_many :orders, through: :order_lines #allows to find all orders for a given product
  has_one_attached :photo

  def total_remaining_quantity
    total_remaining_quantity = 0
    product_lots.each do |product_lot|
      total_remaining_quantity += product_lot.remaining_quantity
    end
    return total_remaining_quantity
  end

  # les méthodes ci-dessous permettent de mapper pour chaque produit son product_type. Les doublons sont ensuite éliminés grâce au .uniq.
  # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
  # LEFT TO DO: GERER LE CAPITALIZE POUR AVOIR LES CHAMPS CAPITALIZES EN VISU map(&:capitalize)

  def self.types
    Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }
    raise
  end

  def self.categories
    Product.all.map(&:product_category).uniq.sort_by { |word| word.downcase }
  end

  def self.fruits
    Product.all.map(&:product_fruit).uniq.sort_by { |word| word.downcase }
  end

end
