class CreateProjectMaterialRequests < ActiveRecord::Migration
  def self.up
    create_table :project_material_requests do |t|
      t.integer :spk_id
      t.string :requester
      t.date :due_date

      t.timestamps
    end
  end

  def self.down
    drop_table :project_material_requests
  end
end
