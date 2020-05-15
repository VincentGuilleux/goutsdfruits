class ChangeColumnNameDeliveryPlacePostCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :delivery_places, :postcode, :post_code
  end
end
