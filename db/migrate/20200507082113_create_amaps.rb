class CreateAmaps < ActiveRecord::Migration[6.0]
  def change
    create_table :amaps do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :adress
      t.string :post_code
      t.string :city

      t.timestamps
    end
  end
end
