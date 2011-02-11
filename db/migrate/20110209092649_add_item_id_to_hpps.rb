class AddItemIdToHpps < ActiveRecord::Migration
  def self.up
    add_column :hpps, :item_id, :integer
  end

  def self.down
    remove_column :hpps, :item_id
  end
end
