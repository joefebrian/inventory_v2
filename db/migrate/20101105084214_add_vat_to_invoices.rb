class AddVatToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :vat, :integer
  end

  def self.down
    remove_column :invoices, :vat
  end
end
