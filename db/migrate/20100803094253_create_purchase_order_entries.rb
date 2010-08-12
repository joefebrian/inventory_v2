class CreatePurchaseOrderEntries < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_entries do |t|
      t.integer :purchase_order_id
      t.integer :item_id
      t.integer :quantity
      t.integer :purchase_price
      t.integer :discount

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_entries
  end
end
