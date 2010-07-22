class CreateSalesOrders < ActiveRecord::Migration
  def self.up
    create_table :sales_orders do |t|
      t.integer, :company_id
      t.integer, :quotation_id
      t.string, :number
      t.date, :tanggal
      t.integer, :top
      t.integer, :advance
      t.integer, :status
      t.integer, :totral_bruto
      t.integer, :total_disc
      t.integer :total_netto
      t.timestamps
    end
  end
  
  def self.down
    drop_table :sales_orders
  end
end
