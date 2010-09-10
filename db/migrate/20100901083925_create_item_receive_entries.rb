class CreateItemReceiveEntries < ActiveRecord::Migration
  def self.up
    create_table :item_receive_entries do |t|
      t.integer :item_receive_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :item_receive_entries
  end
end
