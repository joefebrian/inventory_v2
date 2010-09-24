class AddPluIdToItemReceiveEntries < ActiveRecord::Migration
  def self.up
    add_column :item_receive_entries, :plu_id, :integer
  end

  def self.down
    remove_column :item_receive_entries, :plu_id
  end
end
