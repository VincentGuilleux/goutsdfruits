class AddUnitTypeShopToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :unit_type_shop, :string
  end
end
