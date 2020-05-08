class RemoveCreatedatFromClient < ActiveRecord::Migration[6.0]
  def change

    remove_column :clients, :created_at, :string
  end
end
