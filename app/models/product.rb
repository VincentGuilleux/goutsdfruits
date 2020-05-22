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

  def price_display
    if current_client.segment == "magasin"
      product_price = product.unit_price_cents_shop
    else
      product_price = product.unit_price_cents
    end
  end

  # les méthodes ci-dessous permettent de mapper pour chaque produit type/category/fruit. Les doublons sont ensuite éliminés grâce au .uniq.
  # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
  # LEFT TO DO: GERER LE CAPITALIZE POUR AVOIR LES CHAMPS CAPITALIZES EN VISU map(&:capitalize)

  def self.units
    Product.all.map(&:unit_type).uniq.sort_by { |word | word.downcase }
  end

  def self.unit_measures
    Product.all.map(&:unit_measure).uniq.sort_by { |word| word.downcase }
  end

  def self.types
    Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }
  end

  def self.categories
    Product.all.map(&:product_category).uniq.sort_by { |word| word.downcase }
  end

  def self.fruits
    Product.all.map(&:product_fruit).uniq.sort_by { |word| word.downcase }
  end

end
