class CreateMaterialRequestsPurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :material_requests_purchase_orders, :id => false do |t|
      t.integer :material_request_id
      t.integer :purchase_order_id
    end
  end

  def self.down
    drop_table :material_requests_purchase_orders
  end
end
