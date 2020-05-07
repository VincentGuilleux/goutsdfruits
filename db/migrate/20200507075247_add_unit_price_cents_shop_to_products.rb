class AddUnitPriceCentsShopToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :unit_price_cents_shop, :integer
  end
end
