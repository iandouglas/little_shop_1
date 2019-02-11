class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :email
      t.string :password
      t.integer :role
      t.integer :enabled

      t.timestamps
    end
  end
end
