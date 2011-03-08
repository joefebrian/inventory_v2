class AddTypeToLotItems < ActiveRecord::Migration
  def self.up
    add_column :lot_items, :type, :string
  end

  def self.down
    remove_column :lot_items, :type
  end
end
