class AddDiscountToSalesInvoices < ActiveRecord::Migration
  def self.up
    add_column :sales_invoices, :discount, :integer
  end

  def self.down
    remove_column :sales_invoices, :discount
  end
end
