class AddDeliveredQuantityToProjectMaterials < ActiveRecord::Migration
  def self.up
    add_column :lot_items, :delivered_quantity, :integer
  end

  def self.down
    remove_column :lot_items, :delivered_quantity
  end
end
