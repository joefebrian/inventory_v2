class CreateSalesOrderEntries < ActiveRecord::Migration
  def self.up
    create_table :sales_order_entries do |t|
      t.integer, :sales_order_id
      t.string, :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_order_entries
  end
end
