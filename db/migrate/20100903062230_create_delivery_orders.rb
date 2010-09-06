class CreateDeliveryOrders < ActiveRecord::Migration
  def self.up
    create_table :delivery_orders do |t|
      t.integer :company_id
      t.integer :sales_order_id
      t.string :number
      t.date :date
      t.string :reference
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :delivery_orders
  end
end
