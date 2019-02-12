class ChangeItemsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :enabled, :integer, default: 0
  end
end
