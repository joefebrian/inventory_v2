class CreateCustomerPrices < ActiveRecord::Migration
  def self.up
    create_table :customer_prices do |t|
      t.integer :customer_id
      t.integer :item_id
      t.integer :unit_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :customer_prices
  end
end
