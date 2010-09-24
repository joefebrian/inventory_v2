class AddConfirmedToItemReceives < ActiveRecord::Migration
  def self.up
    add_column :item_receives, :confirmed, :boolean
  end

  def self.down
    remove_column :item_receives, :confirmed
  end
end
