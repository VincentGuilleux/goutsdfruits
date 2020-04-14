class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.integer :total_price_cents
      t.string :status
      t.string :payment_method
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
