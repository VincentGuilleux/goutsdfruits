module ProductsHelper

  def products_types_to_display
      types_to_display = Product.all.map(&:product_type).uniq.sort_by { |word| word.downcase }
      # on n'affiche ici que les types existants avec quantité positive dans les produits de la db contrairement à self.types qui contient tous les types potentiels
      #itération sur chaque produit, les doublons sont  éliminés grâce au .uniq.
    # &:product_type est un raccourci syntaxtique qui correspond à : Product.all.map do |product| product.fruit_product
      types_to_display.unshift('Type')
    end

  def display_price(product, user, type_price)
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

end
