class AddDeliveryIdToProjectBaseMaterials < ActiveRecord::Migration
  def self.up
    add_column :project_base_materials, :delivery_id, :integer
  end

  def self.down
    remove_column :project_base_materials, :delivery_id
  end
end
