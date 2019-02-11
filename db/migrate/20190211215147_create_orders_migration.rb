class CreateOrdersMigration < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_migrations do |t|
      t.integer :user_id
      t.integer :enabled

      t.timestamps
    end
  end
end
