class AddTotalToItemReceiveEntry < ActiveRecord::Migration
  def self.up
    add_column :item_receive_entries, :total, :integer
  end

  def self.down
    remove_column :item_receive_entries, :total
  end
end
