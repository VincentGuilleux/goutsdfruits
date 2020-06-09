class Product < ApplicationRecord

  has_many :product_lots
  has_many :order_lines
  has_many :orders, through: :order_lines #allows to find all orders for a given product
  has_one_attached :photo
  validates :photo, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :unit_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price_cents_shop, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_type, presence: true
  validates :unit_measure, presence: true
  validates :unit_measure_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_measure_quantity_shop, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product_type, presence: true
  validates :product_fruit, presence: true
  validates :product_category, presence: true

  def total_remaining_quantity
    product_lots.sum(:remaining_quantity)
  end

  def unit_price_cents_VAT
    (unit_price_cents / (1 + VATRATE) * VATRATE).round(0)
  end

  def unit_price_cents_shop_VAT
    (unit_price_cents_shop / (1 + VATRATE) * VATRATE).round(0)
  end

  def unit_price_cents_ET
    unit_price_cents - unit_price_cents_VAT
  end

  def unit_price_cents_shop_ET
    unit_price_cents_shop - unit_price_cents_shop_VAT
  end

  def self.remaining_quantities
    @products = Product.all
    remaining_quantities = []
    @products.each do |product|
      remaining_quantity = []
      remaining_quantity << product.id
      remaining_quantity << product.total_remaining_quantity
      remaining_quantities << remaining_quantity
    end
    return remaining_quantities
  end

   # les méthodes ci-dessous permettaient d'itérer pour chaque produit, les doublons sont ensuite éliminés grâce au .uniq.
  # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
  #  def self.unit_measures
  #   Product.all.map(&:unit_measure).uniq.sort_by { |word| word.downcase }
  # end

  def self.units
    ["barquette", "bocal", "bouteille", "pot", "sachet"]
  end

  def self.unit_measures
    ["cl", "g", "ml"]
  end

  def self.types
    ["bonbon", "compote", "coulis", "fruit", "fruit au sirop", "gelée", "pâte à tartiner", "sirop", "sorbet"]
  end

  def self.categories
    ["Fruit frais", "Gourmandise"]
  end

  def self.fruits
    ["cassis", "cerise", "coing", "courge", "fraise", "framboise", "groseille", "menthe", "mix", "mûre", "poire", "pomme", "prune", "pêche", "rhubarbe", "sureau"]
  end

  # les méthodes ci-dessous répondent à une logique d'affichage uniquement donc pourraient être mises dans un helper plutôt
  def display_price(user, type_price)
    price = # raccourci Ruby pour stocker le résultat des conditions ci-dessous dans une variable price
      if user && user.role == "admin"
        if type_price == "magasin"
          unit_price_cents_shop
        else
          unit_price_cents
        end
      elsif user && user.segment == 'magasin'
        unit_price_cents_shop_ET
      else
        unit_price_cents
      end
    price/100.to_f
  end

  def display_quantity(user, type_price, product)
    display_quantity =
      if user && user.role == "admin"
        if type_price == "magasin"
          product.total_remaining_quantity * product.unit_measure_quantity / product.unit_measure_quantity_shop
        else
          product.total_remaining_quantity
        end
      # pas d'affichage des quantités en role client
      end
  end

  def display_unit_measure_quantity_shop(user, type_price, product)
    display_unit_measure_quantity_shop =
    unless product.unit_measure_quantity_shop >= 1000 && product.unit_measure = "g"
      product.unit_measure_quantity_shop
    else
      product.unit_measure_quantity_shop / 1000
    end
  end

  def display_unit_measure(user, type_price, product)
    display_unit_measure =
    if (user && user.role == "admin") || (user && user.segment == 'magasin')
      unless product.unit_measure_quantity_shop >= 1000 && product.unit_measure = "g"
        product.unit_measure
      else
        kg
      end
    end
  end


end
