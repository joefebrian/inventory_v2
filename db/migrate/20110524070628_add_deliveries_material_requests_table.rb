class AddDeliveriesMaterialRequestsTable < ActiveRecord::Migration
  def self.up
    create_table 'deliveries_material_requests', :id => false do |t|
      t.integer :delivery_id
      t.integer :material_request_id
    end
  end

  def self.down
    drop_table 'deliveries_material_requests'
  end
end
