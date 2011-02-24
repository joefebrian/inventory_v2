class AddWithTaxToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :with_tax, :boolean, :default => false
  end

  def self.down
    remove_column :purchase_orders, :with_tax
  end
end
