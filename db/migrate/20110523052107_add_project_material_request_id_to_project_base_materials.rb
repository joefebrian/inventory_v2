class AddProjectMaterialRequestIdToProjectBaseMaterials < ActiveRecord::Migration
  def self.up
    add_column :project_base_materials, :project_material_request_id, :integer
  end

  def self.down
    remove_column :project_base_materials, :project_material_request_id
  end
end
