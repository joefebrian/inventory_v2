class AddQuantityToPoMrTrackers < ActiveRecord::Migration
  def self.up
    add_column :po_mr_trackers, :quantity, :integer
  end

  def self.down
    remove_column :po_mr_trackers, :quantity
  end
end
