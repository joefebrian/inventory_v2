class CreatePoMrTrackers < ActiveRecord::Migration
  def self.up
    create_table :po_mr_trackers do |t|
      t.integer :purchase_order_id
      t.integer :material_request_id
      t.boolean :finished

      t.timestamps
    end
  end

  def self.down
    drop_table :po_mr_trackers
  end
end
