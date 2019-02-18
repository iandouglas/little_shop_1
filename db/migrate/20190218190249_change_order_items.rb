class ChangeOrderItems < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :fulfilled, :integer, default: 0
  end
end
