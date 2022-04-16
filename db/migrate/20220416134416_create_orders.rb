class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.float :total_price
      t.string :customer_name
      t.string :customer_email
      t.integer :status

      t.timestamps
    end
  end
end
