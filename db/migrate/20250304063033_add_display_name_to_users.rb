class AddDisplayNameToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :display_name, :string

    # Set display_name to email_address for existing users
    execute <<-SQL
      UPDATE users SET display_name = email_address
    SQL
  end

  def down
    remove_column :users, :display_name
  end
end
