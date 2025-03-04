class AddVisibleToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :visible, :boolean, null: false, default: true
  end
end
