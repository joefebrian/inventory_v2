class CreateDirectSaleEntries < ActiveRecord::Migration
  def self.up
    create_table :direct_sale_entries do |t|
      t.integer :direct_sale_id
      t.integer :item_id
      t.integer :quantity
      t.integer :price
      t.integer :diskon
      t.integer :total_price
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :direct_sale_entries
  end
end
