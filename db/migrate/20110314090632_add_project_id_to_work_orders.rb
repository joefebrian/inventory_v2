class AddProjectIdToWorkOrders < ActiveRecord::Migration
  def self.up
    add_column :work_orders, :project_id, :integer
  end

  def self.down
    remove_column :work_orders, :project_id
  end
end
