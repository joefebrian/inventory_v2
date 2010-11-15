class AddAccountingValidatedToSalesInvoices < ActiveRecord::Migration
  def self.up
    add_column :sales_invoices, :accounting_validated, :boolean, :default => false
  end

  def self.down
    remove_column :sales_invoices, :accounting_validated
  end
end
