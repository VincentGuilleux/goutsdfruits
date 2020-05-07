class AddPickupDateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pickup_date, :date
  end
end
