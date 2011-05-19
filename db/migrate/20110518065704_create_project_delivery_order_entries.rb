class CreateProjectDeliveryOrderEntries < ActiveRecord::Migration
  def self.up
    create_table :project_delivery_order_entries do |t|
      t.integer :project_delivery_order_id
      t.integer :item_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :project_delivery_order_entries
  end
end
