class AddProjectIdToMaterialRequest < ActiveRecord::Migration
  def self.up
    add_column :material_requests, :project_id, :integer
  end

  def self.down
    remove_column :material_requests, :project_id
  end
end
