class AddDiskonToSalesOrderEntry < ActiveRecord::Migration
  def self.up
    add_column :sales_order_entries, :diskon, :integer
  end

  def self.down
    remove_column :sales_order_entries, :diskon
  end
end
