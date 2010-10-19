class CreateSalesReturnEntries < ActiveRecord::Migration
  def self.up
    create_table :sales_return_entries do |t|
      t.integer :sales_return_id
      t.integer :item_id
      t.integer :quantity
      t.integer :price
      t.integer :total_price
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_return_entries
  end
end
