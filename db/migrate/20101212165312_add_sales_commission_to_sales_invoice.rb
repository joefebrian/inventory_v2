class AddSalesCommissionToSalesInvoice < ActiveRecord::Migration
  def self.up
    add_column :sales_invoices, :sales_commission, :integer
  end

  def self.down
    remove_column :sales_invoices, :sales_commission
  end
end
