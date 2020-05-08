class RemoveUpdatedatFromClient < ActiveRecord::Migration[6.0]
  def change

    remove_column :clients, :updated_at, :string
  end
end
