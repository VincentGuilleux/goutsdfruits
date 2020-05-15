class RemoveForeignKeyClients < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:clients, :amap, index: true, foreign_key: true)
  end
end
