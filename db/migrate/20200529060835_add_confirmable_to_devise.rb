class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
    def up
    add_column :clients, :confirmation_token, :string
    add_column :clients, :confirmed_at, :datetime
    add_column :clients, :confirmation_sent_at, :datetime
    # add_column :clients, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :clients, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # clients as confirmed, do the following
    Client.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :clients, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :clients, :unconfirmed_email # Only if using reconfirmable
  end
end
