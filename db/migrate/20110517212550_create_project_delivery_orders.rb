class CreateProjectDeliveryOrders < ActiveRecord::Migration
  def self.up
    create_table :project_delivery_orders do |t|
      t.integer :project_id
      t.integer :material_request_id
      t.date :delivery_date

      t.timestamps
    end
  end

  def self.down
    drop_table :project_delivery_orders
  end
end
