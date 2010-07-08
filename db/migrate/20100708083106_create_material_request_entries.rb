class CreateMaterialRequestEntries < ActiveRecord::Migration
  def self.up
    create_table :material_request_entries do |t|
      t.integer :material_request_id
      t.integer :item_id
      t.integer :quantity
      t.date :estimated_delivery_date

      t.timestamps
    end
  end

  def self.down
    drop_table :material_request_entries
  end
end
