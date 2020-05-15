class CreateDeliveryPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_places do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :postcode
      t.string :city
      t.string :timeslot

      t.timestamps
    end
  end
end
