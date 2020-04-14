class CreateProductLots < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lots do |t|
      t.date :production_date
      t.date :expiry_date
      t.integer :quantity
      t.integer :remaining_quantity
      t.string :lot_number
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
