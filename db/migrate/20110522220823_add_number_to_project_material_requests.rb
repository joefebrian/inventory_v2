class AddNumberToProjectMaterialRequests < ActiveRecord::Migration
  def self.up
    add_column :project_material_requests, :number, :string
  end

  def self.down
    remove_column :project_material_requests, :number
  end
end
