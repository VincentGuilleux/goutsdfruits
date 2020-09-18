module ProductClassesHelper

# METHODES DE CLASSE DU MODELE PRODUIT UTILISEES POUR LES FILTRES DE L'INDEX PRODUITS

  def types_to_display
    types_to_display = Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }
    # on n'affiche ici que les types existants avec quantité positive dans les produits de la db contrairement à self.types qui contient tous les types potentiels
    #itération sur chaque produit, les doublons sont  éliminés grâce au .uniq.
  # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
    types_to_display.unshift('Type')
  end

  def types_to_display_positive_stock
    types_to_display = Product.all.select { |product| product.total_remaining_quantity > 0 }.map(&:product_type).uniq.sort_by { |word| word.downcase }
    types_to_display.unshift('Type')
  end

  def fruits_to_display
    fruits_to_display = Product.all.map(&:product_fruit).uniq.sort_by { |word| word.downcase }
    fruits_to_display.unshift('Fruit')
  end

  def fruits_to_display_positive_stock
    fruits_to_display = Product.all.select { |product| product.total_remaining_quantity > 0 }.map(&:product_fruit).uniq.sort_by { |word| word.downcase }
    fruits_to_display.unshift('Fruit')
  end

end
