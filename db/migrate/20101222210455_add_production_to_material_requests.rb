class AddProductionToMaterialRequests < ActiveRecord::Migration
  def self.up
    add_column :material_requests, :production, :boolean, :default => false
  end

  def self.down
    remove_column :material_requests, :production
  end
end
