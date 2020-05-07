class AddAmapToClients < ActiveRecord::Migration[6.0]
  def change
    add_reference :clients, :amap, foreign_key: true
    # add_reference :clients, :AMAP, null: false, foreign_key: true
  end
end
