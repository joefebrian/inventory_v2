class AddTotalToItemReceive < ActiveRecord::Migration
  def self.up
    add_column :item_receives, :total, :integer
  end

  def self.down
    remove_column :item_receives, :total
  end
end
