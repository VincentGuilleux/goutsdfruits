class ChangeColumnNameDeliveryPlaceTimeSlotWithoutUnderscore < ActiveRecord::Migration[6.0]
  def change
    rename_column :delivery_places, :time_slot, :timeslot
  end
end
