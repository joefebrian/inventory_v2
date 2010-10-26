class CreateDirectSales < ActiveRecord::Migration
  def self.up
    create_table :direct_sales do |t|
      t.integer :company_id
      t.string :number
      t.date :tanggal
      t.integer :customer_id
      t.integer :salesman_id
      t.integer :currency_id
      t.integer :currency_rate
      t.integer :top
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :direct_sales
  end
end
