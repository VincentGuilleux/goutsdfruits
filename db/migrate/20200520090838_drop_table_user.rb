class DropTableUser < ActiveRecord::Migration[6.0]
  def up
    drop_table :users
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
