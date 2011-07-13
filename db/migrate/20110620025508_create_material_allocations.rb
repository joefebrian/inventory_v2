class CreateMaterialAllocations < ActiveRecord::Migration
  def self.up
    create_table :material_allocations do |t|
      t.integer :item_id
      t.string :transaction_ref
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :material_allocations
  end
end
