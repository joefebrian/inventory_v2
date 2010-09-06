class CreateSalesInvoices < ActiveRecord::Migration
  def self.up
    create_table :sales_invoices do |t|
      t.integer :company_id
      t.integer :delivery_order_id
      t.string :number
      t.string :ppn
      t.date :due_date
      t.string :top
      t.timestamps
    end
  end
  
  def self.down
    drop_table :sales_invoices
  end
end
