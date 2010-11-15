class AddVatToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :vat, :integer
    add_column :sales_orders, :vat, :integer
    add_column :direct_sales, :vat, :integer
  end

  def self.down
    remove_column :purchase_orders, :vat
  end
end
