class CreatePriceListEntries < ActiveRecord::Migration
  def self.up
    create_table :price_list_entries do |t|
      t.integer :price_list
      t.integer :item_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :price_list_entries
  end
end
