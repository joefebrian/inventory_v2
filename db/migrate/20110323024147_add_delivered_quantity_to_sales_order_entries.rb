class AddDeliveredQuantityToSalesOrderEntries < ActiveRecord::Migration
  def self.up
    add_column :sales_order_entries, :delivered_quantity, :integer
  end

  def self.down
    remove_column :sales_order_entries, :delivered_quantity
  end
end
