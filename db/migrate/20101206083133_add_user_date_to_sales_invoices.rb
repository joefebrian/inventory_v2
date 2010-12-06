class AddUserDateToSalesInvoices < ActiveRecord::Migration
  def self.up
    add_column :sales_invoices, :user_date, :date
  end

  def self.down
    remove_column :sales_invoices, :user_date
  end
end
