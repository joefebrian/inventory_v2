class AddWorkOrderIdToMaterialRequests < ActiveRecord::Migration
  def self.up
    add_column :material_requests, :work_order_id, :integer
  end

  def self.down
    remove_column :material_requests, :work_order_id
  end
end
