class AddItemIdToPoMrRequests < ActiveRecord::Migration
  def self.up
    add_column :po_mr_trackers, :item_id, :integer
  end

  def self.down
    remove_column :po_mr_trackers, :item_id
  end
end
