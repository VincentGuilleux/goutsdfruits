class Product < ApplicationRecord

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
  # champ ci-dessus obligatoire pour les besoins de la méthode total_remaining_quantity_shop
  validates :product_type, presence: true
  validates :product_fruit, presence: true
  validates :product_category, presence: true

  # Methodes de calcul de la quantité restante pour un produit donné
  def total_remaining_quantity
    product_lots.where("expiry_date > ?", Date.today).sum(:remaining_quantity)
  end

  def total_remaining_quantity_shop
    product_lots.sum(:remaining_quantity) * unit_measure_quantity / unit_measure_quantity_shop
  end

  def ratio
    unit_measure_quantity_shop / unit_measure_quantity
  end


  # Methodes de calcul de la TVA
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

  # Méthodes de classe qui renvoient un array d'arrays d'id et de respectivement remaining_quantity / description / ratio_quantity shop vs client
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

  def self.types_to_display
    Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }
  end
  #itération sur chaque produit, les doublons sont  éliminés grâce au .uniq.
  # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product

  def self.categories
    ["Fruit frais", "Gourmandise"]
  end

  def self.fruits
    ["cassis", "cerise", "coing", "courge", "fraise", "framboise", "groseille", "menthe", "mix", "mûre", "noisette", "poire", "pomme", "prune", "pêche", "raisin", "rhubarbe", "sureau"]
  end

  def self.fruits_to_display
    Product.all.map(&:product_fruit).uniq.sort_by { |word| word.downcase }
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
    if price
      price/100.to_f
    else
      nil # couvre le cas où il n'y a pas de unit_price_cent_shop (cas des produits non vendus aux magasins)
    end
  end

  def display_quantity(user, type_price, product)
    display_quantity =
      if user && user.role == "admin"
        if type_price == "magasin"
          product.total_remaining_quantity * product.unit_measure_quantity / product.unit_measure_quantity_shop
        else
          product.total_remaining_quantity
        end
      else
        ""
      end
  end

  def display_unit_measure_quantity(user, type_price, product)
    display_unit_measure_quantity =
    if (user && user.role == "admin" && type_price == "magasin") || (user && user.segment == 'magasin')
      unless product.unit_measure_quantity_shop >= 1000 && product.unit_measure = "g"
        product.unit_measure_quantity_shop
      else
        product.unit_measure_quantity_shop / 1000
      end
    else
      unless product.unit_measure_quantity >= 1000 && product.unit_measure = "g"
        product.unit_measure_quantity
      else
        product.unit_measure_quantity / 1000
      end
    end
  end

  def display_unit_measure(user, type_price, product)
    display_unit_measure =
    if (user && user.role == "admin" && type_price == "magasin") || (user && user.segment == 'magasin')
      unless product.unit_measure_quantity_shop >= 1000 && product.unit_measure = "g"
        product.unit_measure
      else
        "kg"
      end
    else
      unless product.unit_measure_quantity >= 1000 && product.unit_measure = "g"
        product.unit_measure
      else
        "kg"
      end
    end
  end


end
