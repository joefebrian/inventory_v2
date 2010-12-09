class ChangeDiscuontOnSalesOrders < ActiveRecord::Migration
  def self.up
    rename_column :sales_order_entries, :discuont, :discount
    remove_column :sales_order_entries, :diskon
  end

  def self.down
  end
end
