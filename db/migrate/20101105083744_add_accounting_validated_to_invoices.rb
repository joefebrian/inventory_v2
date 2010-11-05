class AddAccountingValidatedToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :accounting_validated, :boolean, :default => false
  end

  def self.down
    remove_column :invoices, :accounting_validated
  end
end
