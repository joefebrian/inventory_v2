class AddWithTaxToSalesOrders < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :with_tax, :boolean, :default => false
  end

  def self.down
    remove_column :sales_orders, :with_tax
  end
end
