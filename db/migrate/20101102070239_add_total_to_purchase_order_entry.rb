class AddTotalToPurchaseOrderEntry < ActiveRecord::Migration
  def self.up
    add_column :purchase_order_entries, :total, :integer
  end

  def self.down
    remove_column :purchase_order_entries, :total
  end
end
