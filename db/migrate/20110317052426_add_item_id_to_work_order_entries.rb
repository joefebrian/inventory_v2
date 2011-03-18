class AddItemIdToWorkOrderEntries < ActiveRecord::Migration
  def self.up
    add_column :work_order_entries, :item_id, :integer
  end

  def self.down
    remove_column :work_order_entries, :item_id
  end
end
