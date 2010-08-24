class ChangePoMrTrackers < ActiveRecord::Migration
  def self.up
    rename_column :po_mr_trackers, :purchase_order_id, :purchase_order_entry_id
  end

  def self.down
    rename_column :po_mr_trackers, :purchase_order_entry_id, :purchase_order_id
  end
end
