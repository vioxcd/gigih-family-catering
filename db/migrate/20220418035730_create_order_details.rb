class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :menu_item_id
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
