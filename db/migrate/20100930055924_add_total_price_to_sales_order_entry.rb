class AddTotalPriceToSalesOrderEntry < ActiveRecord::Migration
  def self.up
    add_column :sales_order_entries, :price, :integer
    add_column :sales_order_entries, :discuont, :integer
    add_column :sales_order_entries, :total_price, :integer
    add_column :sales_order_entries, :description, :text
  end

  def self.down
    remove_column :sales_order_entries, :description
    remove_column :sales_order_entries, :total_price
    remove_column :sales_order_entries, :discuont
    remove_column :sales_order_entries, :price
  end
end
