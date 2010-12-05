class AddSalesInvoiceIdToDeliveryOrders < ActiveRecord::Migration
  def self.up
    add_column :delivery_orders, :sales_invoice_id, :integer
  end

  def self.down
    remove_column :delivery_orders, :sales_invoice_id
  end
end
