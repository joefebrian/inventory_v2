class AddItemIdToLotItems < ActiveRecord::Migration
  def self.up
    add_column :lot_items, :item_id, :integer
  end

  def self.down
    remove_column :lot_items, :item_id
  end
end
