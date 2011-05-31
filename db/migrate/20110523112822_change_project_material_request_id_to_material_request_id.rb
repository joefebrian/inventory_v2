class ChangeProjectMaterialRequestIdToMaterialRequestId < ActiveRecord::Migration
  def self.up
    rename_column :project_base_materials, :project_material_request_id, :material_request_id
  end

  def self.down
  end
end
