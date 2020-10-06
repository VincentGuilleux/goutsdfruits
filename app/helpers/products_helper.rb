module ProductsHelper

  def products_types_to_display
    #itération sur chaque produit, les doublons sont éliminés grâce au .uniq.
    # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
    if (client_not_logged? || client_non_admin?)
      # on n'affiche que les types existants des produits avec quantité positive
      Product.all.select { |product| product.total_remaining_quantity > 0 }.map(&:product_type).uniq.sort_by { |word| word.downcase }.unshift('Type')
    else
      Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }.unshift('Type')
    end
  end


  def products_fruits_to_display
    Product.all.map(&:product_fruit).uniq.sort_by { |word| word.downcase }.unshift('Fruit')
  end

  def products_fruits_to_display_positive_stock
    Product.all.select { |product| product.total_remaining_quantity > 0 }.map(&:product_fruit).uniq.sort_by { |word| word.downcase }.unshift('Fruit')
  end

  def display_price(product, user, type_price)
    price = # raccourci Ruby pour stocker le résultat des conditions ci-dessous dans une variable price
      if client_admin?
        if type_price == "magasin"
          product.unit_price_cents_shop
        else
          product.unit_price_cents
        end
      elsif client_shop?
        product.unit_price_cents_shop_ET
      else
        product.unit_price_cents
      end
    if price
      price/100.to_f
    else
      nil # couvre le cas où il n'y a pas de unit_price_cent_shop (cas des produits non vendus aux magasins)
    end
  end

  def display_quantity(user, type_price, product)
    display_quantity =
      if client_admin?
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
    if (client_admin? && type_price == "magasin") || (client_shop?)
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
    if (client_admin? && type_price == "magasin") || client_shop?
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
