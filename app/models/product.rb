class Product < ApplicationRecord
  include ProductInstancesHelper
  extend ProductClassesHelper

  has_many :product_lots
  has_many :order_lines
  has_many :orders, through: :order_lines #allows to find all orders for a given product
  has_one_attached :photo
  validates :photo, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :unit_price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price_cents_shop, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :unit_type, presence: true
  validates :unit_measure, presence: true
  validates :unit_measure_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_measure_quantity_shop, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # champ ci-dessus obligatoire pour les besoins de la méthode total_remaining_quantity_shop (même si produit non vendu au magasin)
  validates :product_type, presence: true
  validates :product_fruit, presence: true
  validates :product_category, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true, dictionary: "french" }
    }

  # METHODES CALCUL QUANTITE RESTANTE POUR UN PRODUIT DONNE (NON-SHOP/SHOP)
  def total_remaining_quantity
    product_lots.where("expiry_date > ?", Date.today).sum(:remaining_quantity)
  end

  def total_remaining_quantity_shop
    product_lots.sum(:remaining_quantity) * unit_measure_quantity / unit_measure_quantity_shop
  end

  # METHODE CALCUL RATIO UNIT MEASURE QTY SHOP VS NON-SHOP
  #utilisé dans le controlleur orders dans la création du total order price
  #utilisé dans index products orders pour l'affichage du prix pour un client magasin )
  def ratio
    unit_measure_quantity_shop / unit_measure_quantity
  end

  # METHODES CALCUL TVA
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

  # METHODE NOTIF DASHBOARD STOCK BAS
  def self.lowest_stock
    low_stock_trigger = 3 # Plancher de quantité qui trigger l'alimentation de la liste des low_stocks
    low_stock_list = Array.new
    Product.all.each do |product|
       low_stock_list << product if product.total_remaining_quantity < low_stock_trigger
    end
    low_stock_list.first # Ne renvoit qu'un item pour qu'on n'ait une seule notif pour stock bas
  end

  # METHODES DE CLASSES RENVOYANT UN ARRAY d'ARRAYS [ID ; respectivement remaining_quantity / description / ratio_quantity shop vs client]
  def self.remaining_quantities(user)
    @products = Product.all
    remaining_quantities = []
    @products.each do |product|
      remaining_quantity = []
      remaining_quantity << product.id
      if (user && user.segment == 'magasin')
        remaining_quantity << product.total_remaining_quantity_shop
      else
        remaining_quantity << product.total_remaining_quantity
      end
      remaining_quantities << remaining_quantity
    end
    return remaining_quantities
  end

  def self.descriptions
    @products = Product.all
    descriptions = []
    @products.each do |product|
      descriptions << [product.id, product.description.gsub(/'/,"")]
    end
    return descriptions
  end

  # Méthode de classe qui renvoit le ratio
  def self.ratios_quantities(user)
    @products = Product.all
    ratios = []
    @products.each do |product|
      ratio = []
      ratio << product.id
      if (user && user.segment == 'magasin')
        ratio << product.unit_measure_quantity_shop / product.unit_measure_quantity
      else
        ratio << 1
      end
      ratios << ratio
    end
    return ratios
  end

   # METHODE NOTIF DASHBOARD
  def self.total_value
    @products = Product.all
    products_total_value = 0
    @products.each do |product|
      products_total_value += product.unit_price_cents * product.total_remaining_quantity
    end
    return products_total_value/100
  end

  # METHODES AVEC CONSTANTES SUR LES DIFFERENTS TYPES DE PRODUITS (unités, mesures...)

  def self.units
    ["barquette", "bocal", "bouteille", "pot", "sachet"]
  end

  def self.unit_measures
    ["cl", "g", "ml"]
  end

  def self.types
    ["bonbon", "compote", "coulis", "fruit frais", "fruit au sirop", "gelée", "pâte à tartiner", "sirop", "sorbet"]
  end

  def self.categories
    ["Fruit frais", "Gourmandise"]
  end

  def self.fruits
    ["cassis", "cerise", "coing", "courge", "fraise", "framboise", "groseille", "menthe", "mix", "mûre", "noisette", "poire", "pomme", "prune", "pêche", "raisin", "rhubarbe", "sureau"]
  end

end
