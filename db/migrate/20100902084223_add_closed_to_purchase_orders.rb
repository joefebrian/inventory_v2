class AddClosedToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :purchase_orders, :closed
  end
end
