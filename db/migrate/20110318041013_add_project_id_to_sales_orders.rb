class AddProjectIdToSalesOrders < ActiveRecord::Migration
  def self.up
    add_column :sales_orders, :project_id, :integer
  end

  def self.down
    remove_column :sales_orders, :project_id
  end
end
