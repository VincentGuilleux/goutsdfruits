class ChangeColumnNameDeliveryPlaceTimeSlot < ActiveRecord::Migration[6.0]
  def change
    rename_column :delivery_places, :timeslot, :time_slot
  end
end
