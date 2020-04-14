class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :post_code
      t.string :city
      t.string :segment
      t.string :AMAP_name

      t.timestamps
    end
  end
end
