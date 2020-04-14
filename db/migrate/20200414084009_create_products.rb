class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :description
      t.integer :unit_price_cents
      t.string  :unit_type
      t.string  :product_fruit
      t.string  :product_type
      t.string  :product_category

      t.timestamps
    end
  end
end
