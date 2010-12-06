class AddSupplierInvoiceNumberToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :supplier_invoice_number, :string
  end

  def self.down
    remove_column :invoices, :supplier_invoice_number
  end
end
