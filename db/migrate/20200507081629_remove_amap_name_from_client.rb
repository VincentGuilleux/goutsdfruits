class RemoveAmapNameFromClient < ActiveRecord::Migration[6.0]
  def change

    remove_column :clients, :AMAP_name, :string
  end
end
