class ChangeUsersTable < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :integer, default: 0
    change_column :users, :enabled, :integer, default: 0
  end
end
