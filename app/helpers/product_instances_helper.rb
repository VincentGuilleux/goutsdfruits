module ProductInstancesHelper

# METHODES D'INSTANCE DU MODELE PRODUIT UTILISEES POUR LES FILTRES DE L'INDEX PRODUITS

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
