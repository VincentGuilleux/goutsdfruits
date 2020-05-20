class AddRoleToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :role, :integer
  end
end
