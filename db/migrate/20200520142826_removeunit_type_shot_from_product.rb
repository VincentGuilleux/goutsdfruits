class RemoveunitTypeShotFromProduct < ActiveRecord::Migration[6.0]
  def change
     remove_column :products, :unit_type_shop, :string
  end
end
