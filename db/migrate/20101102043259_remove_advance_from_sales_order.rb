class RemoveAdvanceFromSalesOrder < ActiveRecord::Migration
  def self.up
    remove_column :sales_orders, :advance
    remove_column :sales_orders, :status
    remove_column :sales_orders, :totral_bruto
    remove_column :sales_orders, :total_disc
    remove_column :sales_orders, :total_netto
  end

  def self.down
    add_column :sales_orders, :total_netto, :integer
    add_column :sales_orders, :total_disc, :integer
    add_column :sales_orders, :totral_bruto, :integer
    add_column :sales_orders, :status, :integer
    add_column :sales_orders, :advance, :integer
  end
end
