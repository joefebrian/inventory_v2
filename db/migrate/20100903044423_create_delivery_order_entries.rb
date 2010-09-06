class CreateDeliveryOrderEntries < ActiveRecord::Migration
  def self.up
    create_table :delivery_order_entries do |t|
      t.integer :delivery_order_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :delivery_order_entries
  end
end
