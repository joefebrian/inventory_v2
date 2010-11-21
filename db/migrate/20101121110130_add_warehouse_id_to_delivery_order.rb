class AddWarehouseIdToDeliveryOrder < ActiveRecord::Migration
  def self.up
    add_column :delivery_orders, :warehouse_id, :integer
  end

  def self.down
    remove_column :delivery_orders, :warehouse_id
  end
end
