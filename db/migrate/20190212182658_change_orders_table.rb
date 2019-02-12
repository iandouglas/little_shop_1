class ChangeOrdersTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :enabled, :status
    change_column :orders, :status, :integer, default: 0
  end
end
