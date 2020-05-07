class RenameAmapsAdressToAddress < ActiveRecord::Migration[6.0]
  def change
    rename_column :amaps, :adress, :address
  end
end
