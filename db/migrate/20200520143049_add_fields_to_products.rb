class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :unit_measure, :string
    add_column :products, :unit_measure_quantity, :integer
    add_column :products, :unit_measure_quantity_shop, :integer
  end
end
