class RemoveMaterialRequestIdFromPurchaseOrders < ActiveRecord::Migration
  def self.up
    remove_column :purchase_orders, :material_request_id
  end

  def self.down
    add_column :purchase_orders, :material_request_id, :integer
  end
end
