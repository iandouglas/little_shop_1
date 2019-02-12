class RenameOrdersMigrations < ActiveRecord::Migration[5.1]
  def change
    rename_table :orders_migrations, :orders
  end
end
