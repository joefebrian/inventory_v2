class AddTotalToPurchaseOrder < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :total, :integer
  end

  def self.down
    remove_column :purchase_orders, :total
  end
end
