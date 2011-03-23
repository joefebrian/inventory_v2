class AddProjectIdToDeliveryOrders < ActiveRecord::Migration
  def self.up
    add_column :delivery_orders, :project_id, :integer
  end

  def self.down
    remove_column :delivery_orders, :project_id
  end
end
