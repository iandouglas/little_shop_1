class UpdateOrderItem < ActiveRecord::Migration[5.1]
  def change
     add_column :order_items, :current_price, :float
     add_column :order_items, :quantity, :integer
   end
end
