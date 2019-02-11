class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email
      t.string :password
      t.integer :role
      t.integer :enabled

      t.timestamps
    end
  end
end
