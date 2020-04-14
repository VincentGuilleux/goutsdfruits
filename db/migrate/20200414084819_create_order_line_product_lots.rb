class CreateOrderLineProductLots < ActiveRecord::Migration[6.0]
  def change
    create_table :order_line_product_lots do |t|
      t.integer :quantity
      t.references :product_lot, null: false, foreign_key: true
      t.references :order_line, null: false, foreign_key: true

      t.timestamps
    end
  end
end
