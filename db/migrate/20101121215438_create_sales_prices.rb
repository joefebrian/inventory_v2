class CreateSalesPrices < ActiveRecord::Migration
  def self.up
    create_table :sales_prices do |t|
      t.integer :company_id
      t.date :active_date
      t.integer :plu_id
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_prices
  end
end
