class CreateSpkItems < ActiveRecord::Migration
  def self.up
    create_table :spk_items do |t|
      t.integer :project_work_order_id
      t.integer :item_id
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end
  end

  def self.down
    drop_table :spk_items
  end
end
