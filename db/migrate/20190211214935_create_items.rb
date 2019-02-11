class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string "name"
      t.string "description"
      t.integer "quantity"
      t.float "price"
      t.string "thumbnail"
      t.integer "enabled"
      t.integer "user_id"

      t.timestamps
    end
  end
end
