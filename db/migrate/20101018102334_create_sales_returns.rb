class CreateSalesReturns < ActiveRecord::Migration
  def self.up
    create_table :sales_returns do |t|
      t.integer :company_id
      t.string :number
      t.date :tanggal
      t.integer :customer_id
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :sales_returns
  end
end
