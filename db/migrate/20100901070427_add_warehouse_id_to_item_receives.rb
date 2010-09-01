class AddWarehouseIdToItemReceives < ActiveRecord::Migration
  def self.up
    add_column :item_receives, :warehouse_id, :integer
  end

  def self.down
    remove_column :item_receives, :warehouse_id
  end
end
