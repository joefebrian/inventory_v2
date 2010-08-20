class AddClosedToMaterialRequests < ActiveRecord::Migration
  def self.up
    add_column :material_requests, :closed, :boolean
  end

  def self.down
    remove_column :material_requests, :closed
  end
end
