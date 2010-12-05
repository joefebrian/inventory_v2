class CreateDeliveryOrdersSalesInvoices < ActiveRecord::Migration
  def self.up
    create_table :delivery_orders_sales_invoices, :id => false do |t|
      t.integer :delivery_order_id
      t.integer :sales_invoice_id
      t.timestamp
    end
  end

  def self.down
    drop_table :delivery_orders_sales_invoices
  end
end
