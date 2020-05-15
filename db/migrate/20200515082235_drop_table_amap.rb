class DropTableAmap < ActiveRecord::Migration[6.0]
   def up
    drop_table :amaps
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
